import 'package:flutter/material.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/auth_provider.dart';
import 'package:studentappfirebase/controller/providers/internet_provider.dart';
import 'package:studentappfirebase/view/auth/phone_auth/phone_auth_view.dart';
import 'package:studentappfirebase/view/auth/widgets/sign_signup_widget.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/view/home/home.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';

// ignore: must_be_immutable
class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final authP = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: authClr,
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Text(
              'Hello!\nWelcome back',
              style: TextStyle(
                  color: commonClr, fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          commonHeight,
          SignInAndSignUpView(authP: authP),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Divider(color: kgrey),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Or Continue With',
                    style: TextStyle(color: kgrey),
                  ),
                ),
                Expanded(child: Divider(color: kgrey))
              ],
            ),
          ),
          commonHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await handleGoogleSignIn(context);
                },
                hoverColor: commonClr,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: authClr,
                  child: const Image(
                      image: AssetImage(
                    'assets/icons/google.png',
                  )),
                ),
              ),
              commonWidth,
              InkWell(
                hoverColor: commonClr,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhoneAuthView(),
                      ));
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: authClr,
                  child: const Image(
                    width: 30,
                    image: AssetImage('assets/icons/phone.png'),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> handleGoogleSignIn(context) async {
    final authP = Provider.of<AuthProvider>(context, listen: false);
    final ip = Provider.of<InternetProvider>(context, listen: false);
    await ip.checkConnection();
    if (ip.hasInternet == false) {
      showMsgToast(msg: 'Enable Internet Connection');
    } else {
      await authP.signInWithGoogle(context: context).then((value) =>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeView())));
    }
  }
}

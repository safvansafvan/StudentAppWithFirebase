import 'package:flutter/material.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/auth_provider.dart';
import 'package:studentappfirebase/controller/providers/internet_provider.dart';
import 'package:studentappfirebase/view/auth/phone_auth/phone_auth_view.dart';
import 'package:studentappfirebase/view/auth/widgets/text_field_common.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';

// ignore: must_be_immutable
class AuthView extends StatelessWidget {
  AuthView({super.key});

  GlobalKey<FormState> globelKey = GlobalKey<FormState>();
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
          Form(
            key: globelKey,
            child: Column(
              children: [
                TextFormFieldCommon(
                    controller: authP.emailCtrl,
                    hintText: 'Email',
                    keyType: TextInputType.emailAddress),
                TextFormFieldCommon(
                    controller: authP.passwordCtrl,
                    hintText: 'Password',
                    keyType: TextInputType.emailAddress),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password ?',
                    style: TextStyle(fontWeight: FontWeight.normal),
                  )),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: commonClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Text(
                  'Sign in',
                  style: TextStyle(color: kwhite),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: TextStyle(
                    fontSize: 13, color: kgrey, fontWeight: FontWeight.normal),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ))
            ],
          ),
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
      await authP.signInWithGoogle(context: context);
    }
  }
}

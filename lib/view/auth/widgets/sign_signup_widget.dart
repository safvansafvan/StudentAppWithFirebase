import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/auth_provider.dart';
import 'package:studentappfirebase/controller/providers/internet_provider.dart';
import 'package:studentappfirebase/view/auth/forgot_password/forgot_password.dart';
import 'package:studentappfirebase/view/auth/widgets/text_field_common.dart';
import 'package:studentappfirebase/view/home/home.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';

class SignInAndSignUpView extends StatelessWidget {
  const SignInAndSignUpView({super.key, required this.authP});

  final AuthProvider authP;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, value, _) {
      return Column(
        children: [
          TextFormFieldCommon(
              controller: authP.emailCtrl,
              hintText: 'Email',
              keyType: TextInputType.emailAddress),
          TextFormFieldCommon(
              controller: authP.passwordCtrl,
              hintText: 'Password',
              keyType: TextInputType.name),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsetsDirectional.only(end: 10),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordView(),
                        ));
                  },
                  child: Text(
                    value.isSignUp ? '' : 'Forgot Password ?',
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  )),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: ElevatedButton(
                onPressed: () async {
                  await handleButtonClicks(value, context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(500, 40),
                  backgroundColor: value.isSignUp ? Colors.blue : commonClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Text(
                  value.isSignUp ? 'Sign Up' : 'Sign In',
                  style: TextStyle(color: kwhite),
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value.isSignUp
                    ? "Already have an account?"
                    : "Don't have an account?",
                style: TextStyle(
                    fontSize: 13, color: kgrey, fontWeight: FontWeight.normal),
              ),
              Consumer<AuthProvider>(builder: (context, value, _) {
                return TextButton(
                  onPressed: () {
                    if (value.isSignUp == false) {
                      value.updateFields(true);
                    } else {
                      value.updateFields(false);
                    }
                  },
                  child: Text(
                    value.isSignUp ? 'Sign In' : 'Sign Up',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                );
              })
            ],
          ),
        ],
      );
    });
  }

  Future<void> handleButtonClicks(AuthProvider value, context) async {
    final ip = Provider.of<InternetProvider>(context, listen: false);
    await ip.checkConnection();
    if (ip.hasInternet == true) {
      if (value.emailCtrl.text.isEmpty) {
        showMsgToast(msg: 'Email is empty');
      } else if (value.passwordCtrl.text.isEmpty) {
        showMsgToast(msg: 'Password is empty');
      } else {
        if (value.isSignUp) {
          value.user = await value.signUpWithEmailAndPassword(
              value.emailCtrl.text.trim(), value.passwordCtrl.text.trim());
          if (value.user != null) {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                )).then((v) => value.clearController());
          } else {
            log('something went wrong');
          }
        } else {
          value.user = await value.signInWithEmailAndPasswords(
              value.emailCtrl.text.trim(), value.passwordCtrl.text.trim());
          if (value.user != null) {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeView(),
                )).then((v) => value.clearController());
          } else {
            log('something went wrong');
          }
        }
      }
    } else {
      showMsgToast(msg: 'Enable Internet Connection');
    }
  }
}

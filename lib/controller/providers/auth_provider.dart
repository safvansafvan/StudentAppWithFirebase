import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentappfirebase/view/auth/phone_auth/phone_otp_view.dart';
import 'package:studentappfirebase/view/home/home.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

// phone auth view *******************************************************************************
  String countryCode = '+91';
  TextEditingController phoneNumberCtrl = TextEditingController();
  String verifyId = '';

  Future<void> handlePhoneAuth(context) async {
    log(phoneNumberCtrl.text);
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumberCtrl.text,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          log(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          verifyId = verificationId;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhoneOtpView(),
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      log(e.toString());
    }
  }

  // phoneotp authentication view  ********************************************************************

  final TextEditingController otpController = TextEditingController();

  Future<void> handlePhoneOtpVerification(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    String code = otpController.text;
    log(verifyId);
    log(code);
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verifyId, smsCode: code);
      await auth
          .signInWithCredential(credential)
          .then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              )));
    } catch (e) {
      log(e.toString());
      return showMsgToast(msg: 'Invalid Otp');
    }
  }

  void clearController() {
    phoneNumberCtrl.clear();
    otpController.clear();
  }
}

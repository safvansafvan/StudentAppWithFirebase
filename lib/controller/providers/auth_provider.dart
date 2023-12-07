import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:studentappfirebase/view/auth/authview.dart';
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

// handle continue with google  *********************************************************************
  User? user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        log(e.toString());
      }
    } else {
      log("account is doesn't exist");
    }

    return user;
  }

  handleScreens(context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const HomeView();
    } else {
      return AuthView();
    }
  }

  Future<void> logout(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await auth.signOut();
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AuthView()),
        (route) => false,
      );
      showMsgToast(msg: 'Logout');
    } catch (e) {
      log('Error during logout: $e');
    }
  }

}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/auth_provider.dart';
import 'package:studentappfirebase/controller/providers/internet_provider.dart';
import 'package:studentappfirebase/view/auth/widgets/text_field_common.dart';
import 'package:studentappfirebase/view/widgets/lottie_view.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final authP = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: authClr,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(
                radius: 23,
                backgroundColor: kwhite,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              ),
            ),
          ),
          const LottieView(
              path: 'assets/animations/forgot.json', height: 200, width: 200),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Column(
              children: [
                Text(
                  'Forgot Password ?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text("Please enter email address linked with your account"),
              ],
            ),
          ),
          TextFormFieldCommon(
              controller: authP.forgotPasswordCtrl,
              hintText: 'Email',
              keyType: TextInputType.emailAddress),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: ElevatedButton(
                onPressed: () async {
                  handleForgotPassword(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: commonClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: authP.isForgotLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Reset',
                        style: TextStyle(color: kwhite),
                      )),
          ),
        ],
      ),
    );
  }

  Future<void> handleForgotPassword(context) async {
    final authP = Provider.of<AuthProvider>(context, listen: false);
    final ip = Provider.of<InternetProvider>(context, listen: false);
    await ip.checkConnection();
    if (ip.hasInternet == false) {
      showMsgToast(msg: 'Enable Internet Connection');
    } else {
      await authP.forgotPassword(context);
    }
  }
}

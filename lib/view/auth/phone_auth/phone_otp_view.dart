import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/auth_provider.dart';
import 'package:studentappfirebase/view/widgets/lottie_view.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';

class PhoneOtpView extends StatelessWidget {
  PhoneOtpView({super.key});
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kgrey),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
        border: Border.all(color: commonClr), borderRadius: radiusFive);

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    final authP = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            commonHeight,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: authClr,
                  radius: 30,
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_rounded)),
                ),
              ),
            ),
            const LottieView(
                path: 'assets/animations/otp.json', height: 200, width: 200),
            commonHeight,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                controller: authP.otpController,
                focusNode: focusNode,
                showCursor: true,
                separatorBuilder: (index) => const SizedBox(width: 5),
                length: 6,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: ElevatedButton(
                  onPressed: () async {
                    focusNode.unfocus();
                    if (authP.otpController.length < 6) {
                      showMsgToast(msg: 'Enter valid otp');
                    } else {
                      await authP.handlePhoneOtpVerification(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: commonClr,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: Text(
                    'Verify Number',
                    style: TextStyle(color: kwhite),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

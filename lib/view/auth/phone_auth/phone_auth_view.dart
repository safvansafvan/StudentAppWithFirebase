import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/auth_provider.dart';
import 'package:studentappfirebase/controller/providers/internet_provider.dart';
import 'package:studentappfirebase/view/auth/phone_auth/widget/header.dart';
import 'package:studentappfirebase/view/widgets/lottie_view.dart';
import 'package:studentappfirebase/view/widgets/msg_toast.dart';

import '../widgets/text_field_common.dart';

// ignore: must_be_immutable
class PhoneAuthView extends StatelessWidget {
  PhoneAuthView({super.key});
  GlobalKey<FormState> globelKey = GlobalKey<FormState>();

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
              path: 'assets/animations/lock.json', height: 250, width: 200),
          const HeaderView(),
          Form(
            key: globelKey,
            child: Column(
              children: [
                TextFormFieldCommon(
                    controller: authP.phoneNumberCtrl,
                    hintText: 'Phone',
                    keyType: TextInputType.number)
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            child: ElevatedButton(
                onPressed: () async {
                  await handlePhoneAuth(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: commonClr,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: Text(
                  'Sent Otp',
                  style: TextStyle(color: kwhite),
                )),
          ),
        ],
      ),
    );
  }

  Future<void> handlePhoneAuth(context) async {
    final authP = Provider.of<AuthProvider>(context, listen: false);
    final ip = Provider.of<InternetProvider>(context, listen: false);
    await ip.checkConnection();
    if (ip.hasInternet == false) {
      showMsgToast(msg: 'Enable Internet Connection');
    } else if (authP.phoneNumberCtrl.length < 10) {
      showMsgToast(msg: 'Enter Vaild Number');
    } else {
      await authP.handlePhoneAuth(context);
    }
  }
}

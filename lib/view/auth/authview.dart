import 'package:flutter/material.dart';
import 'package:studentappfirebase/controller/const.dart';
import 'package:studentappfirebase/controller/providers/auth_provider.dart';
import 'package:studentappfirebase/view/auth/widgets/text_field_common.dart';
import 'package:provider/provider.dart';

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
            padding: EdgeInsets.symmetric(vertical: 40),
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
          )
        ],
      ),
    );
  }
}

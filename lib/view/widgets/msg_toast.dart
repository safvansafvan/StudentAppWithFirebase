import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studentappfirebase/controller/const.dart';

showMsgToast({required String msg, Color? bg}) {
  Fluttertoast.showToast(
      textColor: kwhite,
      msg: msg,
      fontSize: 16,
      timeInSecForIosWeb: 3,
      backgroundColor: bg ?? kgrey,
      gravity: ToastGravity.SNACKBAR);
}

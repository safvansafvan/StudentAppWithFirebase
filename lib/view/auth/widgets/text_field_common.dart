import 'package:flutter/material.dart';
import 'package:studentappfirebase/controller/const.dart';

// ignore: must_be_immutable
class TextFormFieldCommon extends StatelessWidget {
  TextFormFieldCommon(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.keyType,
      this.prefixIcon,
      this.maxlength,
      this.suffixIcon});

  final String hintText;
  final TextInputType keyType;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final dynamic maxlength;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(borderRadius: radiusFive);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(color: kwhite, borderRadius: radiusFive),
      child: TextFormField(
        controller: controller,
        maxLength: maxlength,
        keyboardType: keyType,
        validator: (value) {
          if (value!.isEmpty) {
            return "Required";
          }
          return null;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 10),
            prefixIconColor: kblack,
            prefixIcon: prefixIcon,
            suffixIconColor: kblack,
            suffixIcon: suffixIcon,
            hintText: hintText,
            border: border,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none),
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
      ),
    );
  }
}

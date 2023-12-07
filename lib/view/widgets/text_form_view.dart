import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormView extends StatelessWidget {
  TextFormView(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.isNum});

  final TextEditingController controller;
  final String hintText;
  bool isNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: isNum ? TextInputType.number : TextInputType.name,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          labelText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Required';
          } else {
            return null;
          }
        },
      ),
    );
  }
}

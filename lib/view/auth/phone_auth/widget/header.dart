import 'package:flutter/material.dart';
import 'package:studentappfirebase/controller/const.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          const Text(
            'Phone Verification',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          commonHeight,
          const Text(
            'We need register your phone before getting started !',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

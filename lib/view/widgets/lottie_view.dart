import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieView extends StatelessWidget {
  const LottieView({super.key, required this.path, this.height, this.width});

  final String path;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(path, width: width, height: height);
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoTaskWidget extends StatelessWidget {
  const NoTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        "assets/lottie/notdata.json",
        height: 200,
        width: 200,
      )
    );
  }
}
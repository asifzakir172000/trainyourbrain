
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trainyourbrain/controller/SplashController.dart';
import 'package:trainyourbrain/helper/image.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final SplashScreenController mController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: const Color(0xFFFBFCF8),
        child: Lottie.asset(spJson, reverse: false, repeat: false),
    );
  }
}


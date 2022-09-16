
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trainyourbrain/controller/SplashController.dart';
import 'package:trainyourbrain/helper/image.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashScreenController mController = Get.put(SplashScreenController());

  @override
  void initState() {
    mController.splashSetup(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Lottie.asset(spJson, reverse: false, repeat: false,
            height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width, fit: BoxFit.cover),
    );
  }
}


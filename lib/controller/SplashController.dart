
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/view/home.dart';
import 'package:trainyourbrain/view/login/login.dart';

class SplashScreenController extends SuperController{

  splashSetup(context) {
    AudioPlayerClass.instance.playBg(bgAudio, false);
    Future.delayed(const Duration(seconds: 7), () async {
      AudioPlayerClass.instance.dismissBgPlayer();
      var isConnection = await checkUserConnection();
      if(isConnection){
        _checkVersion(context);
      }else{
        Get.offAll(()=>const HomePage(), transition: Transition.rightToLeftWithFade,);
      }
    });
  }

  Future<bool> checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
     return false;
    }

    return false;
  }

  void _checkVersion(context) async {
    final newVersion = NewVersion(
      androidId: "com.aiolos.solutions.trainyourbrain",
    );
    final status = await newVersion.getVersionStatus();
    debugPrint("status : ${status?.canUpdate}");
    if(status != null && status.canUpdate){
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        allowDismissal: false,
        dialogTitle: "UPDATE!!!",
        dismissButtonText: "Skip",
        dialogText: "Please update the app from " + "${status.localVersion}" + " to " + "${status.storeVersion}",
        dismissAction: () {
          navigate();
        },
        updateButtonText: "Lets update",
      );

      print("DEVICE : " + status.localVersion);
      print("STORE : " + status.storeVersion);
    }else{
      navigate();
    }
  }

  navigate(){
    var isLogin = StorageKey.instance.getStorage(key: StorageKey.isLogin) ?? false;
    if(isLogin){
      Get.offAll(()=>const HomePage(), transition: Transition.rightToLeftWithFade,);
    }else{
      Get.offAll(()=>const LoginScreen(), transition: Transition.rightToLeftWithFade,);
    }
  }

  @override
  void onInit() {
    // splashSetup();
    super.onInit();
  }

  @override
  void onDetached() {

  }

  @override
  void onInactive() {

  }

  @override
  void onPaused() {
    AudioPlayerClass.instance.dismissBgPlayer();
  }

  @override
  void onResumed() {
    AudioPlayerClass.instance.restartBg();
  }

}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:video_player/video_player.dart';

class WordColorLevelController extends SuperController{

  var level = 0.obs;

  checkLevel(index){
    var levelC = level.value + 1;
    if(index <= (levelC)){
      return true;
    }else{
      Get.defaultDialog(
          title: "Complete the $levelC level first \nthan you can Play $index Level.",
          middleText: "",
          backgroundColor: Colors.white,
          middleTextStyle: const TextStyle(color: Colors.black),
          radius: 20,
          textCancel: "OK",
      );
    }
    return false;
  }

  getData(){
    level.value = StorageKey.instance.getStorage(key: StorageKey.wordColor)??0;
    debugPrint("f ${level.value}");
  }

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Word Color\nChallenge",
                      style: TextStyle(
                          fontSize: 38,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'HOW TO PLAY',
                  style: TextStyle(
                      fontSize: 28,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.height / 4,
                child: Lottie.asset(cardVideoJson,
                  fit: BoxFit.contain,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Select the correct color shown in word.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }


  @override
  void onInit() {
    getData();
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
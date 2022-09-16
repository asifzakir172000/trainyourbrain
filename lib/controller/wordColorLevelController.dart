import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trainyourbrain/component/infoDialogBox.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:video_player/video_player.dart';

class WordColorLevelController extends GetxController{

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
    showInfoDialog(context, json: wordColorVideoJson, title: "Word Color\nChallenge", des: "Choose the color in which the word is written");
  }


  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
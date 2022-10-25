import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/component/infoDialogBox.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:video_player/video_player.dart';
import 'package:lottie/lottie.dart';
import 'package:trainyourbrain/helper/image.dart';

class FindPathLevelController extends GetxController{

  var level = 0.obs;

  checkLevel(index){
    var levelC = level.value + 1;
    if(index <= (levelC)){
      return true;
    }
    return false;
  }

  getLevel(){
    level.value = StorageKey.instance.getStorage(key: StorageKey.findPath)??0;
  }

  void showCustomDialog(BuildContext context) {
    showInfoDialog(context, json: mazeVideoJson, title: "Find the Path", des: "A rabbit wants a carrot guid the rabbit to find the path");
  }

  @override
  void onInit() {
    getLevel();
    super.onInit();
  }

}
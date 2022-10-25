import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trainyourbrain/component/infoDialogBox.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';

class FindNewLevelController extends GetxController{

  var level = 0.obs;

  checkLevel(index){
    var levelC = level.value + 1;
    if(index <= (levelC)){
      return true;
    }
    return false;
  }

  getLevel(){
    level.value = StorageKey.instance.getStorage(key: StorageKey.findNew)??0;
  }

  void showCustomDialog(BuildContext context) {
    showInfoDialog(context, json: newItemVideoJson, title: "Find New Card", des: "Memorize the object and find the new ones");
  }


  @override
  void onInit() {
    getLevel();
    super.onInit();
  }


}
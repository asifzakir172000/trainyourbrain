import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/helper/storageKey.dart';

class CardLevelController extends GetxController{

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

  getLevel(){
    level.value = StorageKey.instance.getStorage(key: StorageKey.cop)??0;
  }

  @override
  void onInit() {
    getLevel();
    super.onInit();
  }

}
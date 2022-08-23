
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trainyourbrain/controller/findPathLevelController.dart';
import 'package:trainyourbrain/controller/homeController.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/view/maza/mazeData.dart';

class MazeController extends GetxController{

  var rows = 12.obs;
  var columns = 3.obs;
  var isFinished = false.obs;
  var level = 0.obs;
  var isComplete = false.obs;


  onFinishGame(){
    var levelP = StorageKey.instance.getStorage(key: StorageKey.findPath)??0;
    if(levelP < level.value){
      debugPrint(levelP.toString());
      StorageKey.instance.setStorage(key: StorageKey.findPath, msg: level.value);
      var per = StorageKey.instance.getStorage(key: StorageKey.reasoningPer)??0.0;
      debugPrint(per.toString());
      StorageKey.instance.setStorage(key: StorageKey.reasoningPer, msg: per + 1);
      Get.find<FindPathLevelController>().getLevel();
      Get.find<HomeController>().setData();
    }
    isFinished.value = true;
    debugPrint('Hi from finish line!');
  }

  cleanData(){
     isFinished.value = false;
     if(level.value == 5){
       isComplete.value = true;
     }
  }

  onRestartGame(){
    cleanData();
  }

  nextLevel(levelC){
    debugPrint('$levelC');
    rows.value = levelC <= 1 ? mazeData[levelC]["row"] : Random().nextInt(10) + 10;
    columns.value = levelC <= 1 ? mazeData[levelC]["column"] : Random().nextInt(10) + 10;
    level.value = levelC + 1;
    cleanData();
  }

  @override
  void onInit() {
    rows.value = Get.arguments["rows"]??12;
    columns.value = Get.arguments["columns"]??12;
    level.value = Get.arguments["level"]??0;
    super.onInit();
  }

}
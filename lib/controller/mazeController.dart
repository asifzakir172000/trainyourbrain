
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/controller/findPathLevelController.dart';
import 'package:trainyourbrain/controller/homeController.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/model/homeData.dart';
import 'package:trainyourbrain/view/maza/mazeData.dart';

class MazeController extends SuperController{

  var rows = 12.obs;
  var columns = 3.obs;
  var isFinished = false.obs;
  var level = 0.obs;
  var isComplete = false.obs;
  var start = true.obs;


  onFinishGame(){
    playCardAudio(wrongAudio);
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
    startGame();
    cleanData();
  }

  nextLevel(levelC){
    debugPrint('$levelC');
    rows.value = levelC <= 1 ? mazeData[levelC]["row"] : Random().nextInt(10) + 10;
    columns.value = levelC <= 1 ? mazeData[levelC]["column"] : Random().nextInt(10) + 10;
    level.value = levelC + 1;
    cleanData();
    startGame();
  }

  @override
  InternalFinalCallback<void> get onStart => super.onStart;


  startGame(){
    start.value = true;
    Future.delayed(const Duration(seconds: 4), () {
      start.value = false;
    });
  }

  @override
  void onInit() {
    rows.value = Get.arguments["rows"]??12;
    columns.value = Get.arguments["columns"]??12;
    level.value = Get.arguments["level"]??0;
    startGame();
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
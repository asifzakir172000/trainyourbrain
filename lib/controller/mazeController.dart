
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
  var timeLimits = 30.obs;
  var isRetry = false.obs;


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
    isRetry.value = false;
  }

  cleanData(){
    start.value = true;
    Future.delayed(const Duration(seconds: 4), () {
      start.value = false;
      AudioPlayerClass.instance.dismiss();
    });
     isFinished.value = false;
    isRetry.value = false;
     if(level.value == 5){
       isComplete.value = true;
     }
  }

  onRestartGame(){
    cleanData();
  }

  nextLevel(levelC){
    rows.value = levelC <= 1 ? mazeData[levelC]["row"] : Random().nextInt(10) + 10;
    columns.value = levelC <= 1 ? mazeData[levelC]["column"] : Random().nextInt(10) + 10;
    level.value = levelC + 1;
    if(level >= 3){
      timeLimits.value = 60;
    }else{
      timeLimits.value = 30;
    }
    cleanData();
  }

  isFinish(){
    isFinished.value = true;
    isRetry.value = true;
  }

  @override
  InternalFinalCallback<void> get onStart => super.onStart;

  @override
  void onInit() {
    rows.value = Get.arguments["rows"]??12;
    columns.value = Get.arguments["columns"]??12;
    level.value = Get.arguments["level"]??1;
    if(level <= 3){
      timeLimits.value = 60;
    }
    cleanData();
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

  @override
  void dispose() {
    AudioPlayerClass.instance.dismiss();
    super.dispose();
  }

}
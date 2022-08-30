
import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trainyourbrain/controller/findNewLevelController.dart';
import 'package:trainyourbrain/controller/homeController.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/model/homeData.dart';
import 'package:trainyourbrain/view/findNew/findNewData.dart';

class FindNewController extends SuperController{

  var start = true.obs;
  var left = 3.obs;
  var isFinished = false.obs;
  var data = <String>[].obs;
  var showData = <String>[].obs;
  var isSelected = <bool>[].obs;
  var cardStateKeys = <GlobalKey<FlipCardState>>[].obs;
  var answerData = <String>[].obs;
  var showCardLen = 0.obs;
  var level = 0.obs;
  var num = 0.obs;
  var isComplete = false.obs;
  var notComplete = false;
  int clickCount = 0;
  var isCorrectCount = 0.obs;
  var correctIndex = <int>[].obs;
  var inCorrectIndex = <int>[].obs;

  cleanData(){
    data.clear();
    showData.clear();
    isSelected.clear();
    answerData.clear();
    left = 3.obs;
    start = true.obs;
  }

  void restartGame(){
    cleanData();
    correctIndex.clear();
    inCorrectIndex.clear();
    isCorrectCount.value = 0;
    clickCount = 0;
    data.value = getFindNewSourceArray(num.value);
    showData.value = getFindNewShowItemState(showCardLen.value, data);
    isSelected.value = getFindNewSelectedItemState(showData.length);
    start.value = true;
    left.value = (data.length ~/ 2);
    isFinished.value = false;
    Future.delayed(const Duration(seconds: 4), () {
      start.value = false;
      AudioPlayerClass.instance.dismiss();
    });
  }

  onNewItemCheck(index){
    clickCount += 1;
    if(!data.contains(showData[index]) && !answerData.contains(showData[index])){
      isSelected[index] = true;
      isCorrectCount += 1;
      correctIndex.add(index);
      playCardAudio(wrongAudio);
    }else{
      isSelected[index] = true;
      inCorrectIndex.add(index);
      playCardAudio(thunderAudio);
    }
    if(clickCount == showCardLen.value && isCorrectCount.value == showCardLen.value){
      var levelP = StorageKey.instance.getStorage(key: StorageKey.findNew)??0;
      if(levelP < level.value){
        StorageKey.instance.setStorage(key: StorageKey.findNew, msg: level.value);
        var per = StorageKey.instance.getStorage(key: StorageKey.reasoningPer)??0.0;
        StorageKey.instance.setStorage(key: StorageKey.reasoningPer, msg: per + 1);
        Get.find<FindNewLevelController>().getLevel();
        Get.find<HomeController>().setData();
      }
     Future.delayed(const Duration(milliseconds: 500), (){
       isFinished.value = true;
       if(level.value == 5){
         isComplete.value = true;
       }
     });
    }else if(clickCount == showCardLen.value){
      Future.delayed(const Duration(milliseconds: 500), (){
        notComplete = true;
        isFinished.value = true;
        if(level.value == 5){
          isComplete.value = true;
        }
      });
    }
  }

  onNextLevel(levelC){
    if(notComplete){
      restartGame();
    }else{
      num.value = levelC >= 2 ? 3 : 2;
      if(levelC >= 2 && levelC <= 3){
        showCardLen.value = 2;
      }else if(levelC >= 4 ){
        showCardLen.value = 3;
      }
      level.value = levelC + 1;
      restartGame();
    }
  }


  @override
  void onInit() {
    num.value = Get.arguments["num"]!;
    showCardLen.value = Get.arguments["showCard"]!;
    level.value = Get.arguments["level"]!;
    restartGame();
    super.onInit();
  }

  @override
  void dispose() {
    AudioPlayerClass.instance.dismiss();
    super.dispose();
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
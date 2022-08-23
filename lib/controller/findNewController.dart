
import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/controller/findNewLevelController.dart';
import 'package:trainyourbrain/controller/homeController.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/view/card/cardData.dart';
import 'package:trainyourbrain/view/findNew/findNewData.dart';

class FindNewController extends GetxController{

  var start = false.obs;
  // var wait = false.obs;
  Timer? timer;
  var time = 0.obs;
  var left = 3.obs;
  var isFinished = false.obs;
  var data = <String>[].obs;
  var showData = <String>[].obs;
  var isSelected = <bool>[].obs;
  var cardStateKeys = <GlobalKey<FlipCardState>>[].obs;
  var answerData = <String>[].obs;
  late int showCardLen;
  var level = 0.obs;
  var num = 0.obs;
  var isComplete = false.obs;



  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      time.value = time.value - 1;
    });
  }

  cleanData(){
    data.clear();
    showData.clear();
    isSelected.clear();
    answerData.clear();
    time = 0.obs;
    left = 3.obs;
    start = false.obs;
  }

  void restartGame(){
    cleanData();
    startTimer();
    debugPrint("numfrom $num");
    debugPrint("showCardLen $showCardLen");
    data.value = getFindNewSourceArray(num.value);
    showData.value = getFindNewShowItemState(showCardLen, data.value);
    isSelected.value = getFindNewSelectedItemState(showData.length);
    time.value = 3;
    left.value = (data.length ~/ 2);
    isFinished.value = false;
    debugPrint("1: ${start.value}");
    Future.delayed(const Duration(seconds: 3), () {
      start.value = true;
      timer!.cancel();
    });
  }

  onNewItemCheck(index){
    debugPrint("numfrom ${showData[index]}");
    debugPrint("numfrom ${data.contains(showData[index])}");
    if(!data.contains(showData[index]) && !answerData.contains(showData[index])){
      debugPrint("numfrom $answerData");
      answerData.add(showData[index]);
      debugPrint("numfrom $answerData");
      isSelected[index] = true;
    }
    if(answerData.length == showCardLen){
      debugPrint("fs ${level.value}");
      var levelP = StorageKey.instance.getStorage(key: StorageKey.findNew)??0;
      if(levelP < level.value){
        debugPrint("fss $levelP");
        StorageKey.instance.setStorage(key: StorageKey.findNew, msg: level.value);
        var per = StorageKey.instance.getStorage(key: StorageKey.reasoningPer)??0.0;
        StorageKey.instance.setStorage(key: StorageKey.reasoningPer, msg: per + 1);
        Get.find<FindNewLevelController>().getLevel();
        Get.find<HomeController>().setData();
      }
      isFinished.value = true;
      if(level.value == 5){
        isComplete.value = true;
      }
    }
  }

  onNextLevel(levelC){
    num.value = levelC >= 2 ? 3 : 2;
    if(levelC >= 2 && levelC <= 3){
      showCardLen = 2;
    }else if(levelC >= 4 ){
      showCardLen = 3;
    }
    level.value = levelC + 1;
    restartGame();
  }

  @override
  void onInit() {
    num.value = Get.arguments["num"]!;
    showCardLen = Get.arguments["showCard"]!;
    level.value = Get.arguments["level"]!;
    restartGame();
    super.onInit();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

}
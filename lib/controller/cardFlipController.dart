
import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/controller/cardLevelController.dart';
import 'package:trainyourbrain/controller/homeController.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/view/card/cardData.dart';

class CardFlipController extends SuperController{
  var previousIndex = -1.obs;
  var flip = false.obs;
  var start = false.obs;
  var wait = false.obs;
  Timer? timer;
  var time = 0.obs;
  var left = 3.obs;
  var isFinished = false.obs;
  var isComplete = false.obs;
  var data = <String>[].obs;
  var cardFlips = <bool>[].obs;
  var cardStateKeys = <GlobalKey<FlipCardState>>[].obs;
  var level = 0.obs;
  var num = 0.obs;



  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      time.value = time.value - 1;
    });
  }

  void restart(){
    startTimer();
    data.value = getSourceArray(num.value);
    cardFlips.value = getInitialItemState(num.value);
    cardStateKeys.value = getCardStateKeys(num.value);
    time.value = 3;
    left.value = (data.length ~/ 2);
    isFinished.value = false;
    Future.delayed(const Duration(seconds: 3), () {
      start.value = true;
      timer!.cancel();
      debugPrint("2: ${start.value}");
    });
  }

  nextLevel(levelC){
    num.value = levelC >= 2 ? 6 : 4;
    level.value = levelC + 1;
    restart();
  }

  onFlip(index){
    if (!flip.value) {
      flip.value = true;
      previousIndex= index;
    } else {
      flip.value = false;
      if (previousIndex != index) {
        if (data[previousIndex] !=
            data[index]) {
          wait.value = true;
          Future.delayed(
              const Duration(milliseconds: 200),
                  () {
                cardStateKeys[previousIndex]
                    .currentState!
                    .toggleCard();

                previousIndex = index;

                cardStateKeys[previousIndex]
                    .currentState!
                    .toggleCard();

                Future.delayed(
                    const Duration(milliseconds: 300),
                        () {
                          wait.value = false;
                    });
              });
        } else {
          cardFlips[previousIndex] = false;
          cardFlips[index] = false;
          left = left - 1;
          if (cardFlips
              .every((t) => t == false)) {
            Future.delayed(
                const Duration(milliseconds: 160),
                    () {
                      var levelP = StorageKey.instance.getStorage(key: StorageKey.cop)??0;
                      if(levelP < level.value){
                        StorageKey.instance.setStorage(key: StorageKey.cop, msg: level.value);
                        var per = StorageKey.instance.getStorage(key: StorageKey.reasoningPer)??0.0;
                        StorageKey.instance.setStorage(key: StorageKey.reasoningPer, msg: per + 1);
                        Get.find<CardLevelController>().getLevel();
                        Get.find<HomeController>().setData();
                      }
                      isFinished.value = true;
                      start.value = false;
                      if(level.value == 5){
                        isComplete.value = true;
                      }
                });
          }
        }
      }
    }

  }

  @override
  void onInit() {
    num.value = Get.arguments["num"]!;
    level.value = Get.arguments["level"]!;
    restart();
    super.onInit();
  }

  @override
  void dispose() {
    timer!.cancel();
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
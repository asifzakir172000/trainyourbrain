import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/controller/cardLevelController.dart';
import 'package:trainyourbrain/controller/homeController.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/model/homeData.dart';
import 'package:trainyourbrain/view/card/cardData.dart';

class CardFlipController extends GetxController{
  var previousIndex = -1.obs;
  var flip = false.obs;
  var start = true.obs;
  var wait = false.obs;
  var left = 3.obs;
  var isFinished = false.obs;
  var isComplete = false.obs;
  var data = <String>[].obs;
  var cardFlips = <bool>[].obs;
  var cardStateKeys = <GlobalKey<FlipCardState>>[].obs;
  var level = 0.obs;
  var num = 0.obs;


  void restart(){
    data.value = getSourceArray(num.value);
    cardFlips.value = getInitialItemState(num.value);
    cardStateKeys.value = getCardStateKeys(num.value);
    left.value = (data.length ~/ 2);
    isFinished.value = false;
    start.value = true;
    Future.delayed(const Duration(seconds: 3), () {
      AudioPlayerClass.instance.dismiss();
      start.value = false;
    });
  }

  nextLevel(levelC){
    num.value = levelC >= 2 ? 6 : 4;
    level.value = levelC + 1;
    restart();
  }

  onFlip(index){
    playCardAudio(cardFlipAudio);
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
          //
        } else {
          cardFlips[previousIndex] = false;
          cardFlips[index] = false;
          left = left - 1;
          playAudio(wrongAudio);
          if (cardFlips
              .every((t) => t == false)) {
            var levelP = StorageKey.instance.getStorage(key: StorageKey.cop)??0;
            if(levelP < level.value){
              StorageKey.instance.setStorage(key: StorageKey.cop, msg: level.value);
              var per = StorageKey.instance.getStorage(key: StorageKey.reasoningPer)??0.0;
              StorageKey.instance.setStorage(key: StorageKey.reasoningPer, msg: per + 1);
              Get.find<CardLevelController>().getLevel();
              Get.find<HomeController>().setData();
            }
            Future.delayed(
                const Duration(seconds: 1),
                    () {
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



}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/controller/homeController.dart';
import 'package:trainyourbrain/controller/wordColorLevelController.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/constants.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/model/homeData.dart';
import 'package:trainyourbrain/model/wordCOlorModel.dart';
import 'package:trainyourbrain/model/wordColorOptionalModel.dart';
import 'package:trainyourbrain/view/wordColor/wordColorData.dart';

class WordColorController extends SuperController{

  var questionText = "".obs;
  var answer = "".obs;
  var option = <WordColorOptionalModel>[].obs;
  var index = 0.obs;
  var isFinish = false.obs;
  var colorToShow = "".obs;
  var questionLen = 0.obs;
  var level = 0.obs;
  var num = 0.obs;
  var wordColorModel = <WordColorModel>[].obs;
  var isComplete = false.obs;
  var borderColor = "".obs;
  var correctAnsCount = 0.obs;

  setUpQuestion(){
    option.clear();
    debugPrint(index.value.toString());
    wordColorModel.value = getWordColorModelData(num.value);
    questionLen.value = wordColorModel.length;
    setQuestion();
  }

  setQuestion(){
    option.clear();
    questionText.value = wordColorModel[index.value].questionTex!;
    answer.value = wordColorModel[index.value].correctColor!;
    borderColor.value = wordColorModel[index.value].questionTextColor!;
    colorToShow.value = answer.value;
    option.addAll(wordColorModel[index.value].optionModel!);
  }

  calculatePer(){
    return ((correctAnsCount.value / questionLen.value) * 100).round();
  }

  gameFinish(){
    var levelP = StorageKey.instance.getStorage(key: StorageKey.wordColor)??0;
    if(levelP < level.value){
      StorageKey.instance.setStorage(key: StorageKey.wordColor, msg: level.value);
      var per = StorageKey.instance.getStorage(key: StorageKey.attentionPer)??0.0;
      StorageKey.instance.setStorage(key: StorageKey.attentionPer, msg: per + 1);
      Get.find<WordColorLevelController>().getData();
      Get.find<HomeController>().setData();
    }
    index.value = 0;
    isFinish.value = true;
    if(level.value == 5){
      isComplete.value = true;
    }
  }

  onCheck(correctAns, shakeKey){
    if(correctAns == answer.value){
      playCardAudio(wrongAudio);
      correctAnsCount += 1;
      index += 1;
      if(index.value < questionLen.value){
        setQuestion();
      }else{
        gameFinish();
      }
    }else{
      playCardAudio(thunderAudio);
      shakeKey.currentState?.shake();
      index += 1;
      if(index.value < questionLen.value){
        setQuestion();
      }
      if(index.value == questionLen.value){
        gameFinish();
      }
    }
  }

  onNextLevel(){
    level += 1;
    num.value = level.value >= 2 ? 6 : 10;
    correctAnsCount.value = 0;
    setUpQuestion();
    isFinish.value = false;
  }

  restartGame(){
    index.value = 0;
    correctAnsCount.value = 0;
    isFinish.value = false;
    setUpQuestion();
  }

  Color colorConvert(String color) {
    Color actualCode = const Color(0xFF000000);
    color = color.replaceAll("#", "");
    if (color.length == 6) {
      actualCode = Color(int.parse("0xFF$color"));
    } else if (color.length == 8) {
      actualCode =  Color(int.parse("0x$color"));
    }
    return actualCode;
  }


  @override
  void onInit() {
    level.value = Get.arguments["level"]!;
    num.value = Get.arguments["num"]!;
    setUpQuestion();
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
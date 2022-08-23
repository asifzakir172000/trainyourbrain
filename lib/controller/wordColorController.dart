
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/controller/homeController.dart';
import 'package:trainyourbrain/controller/wordColorLevelController.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/model/wordCOlorModel.dart';
import 'package:trainyourbrain/model/wordColorOptionalModel.dart';
import 'package:trainyourbrain/view/wordColor/wordColorData.dart';

class WordColorController extends GetxController{

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
    colorToShow.value = wordColorModel[index.value].questionTextColor!;
    option.addAll(wordColorModel[index.value].optionModel!);
  }

  onCheck(correctAns){
    debugPrint(correctAns);
    debugPrint(answer.value);
    if(correctAns == answer.value){
      debugPrint("f ${answer.value}");
      index += 1;
      if(index.value < questionLen.value){
        setQuestion();
      }else{
        debugPrint("fs ${level.value}");
        var levelP = StorageKey.instance.getStorage(key: StorageKey.wordColor)??0;
        if(levelP < level.value){
          debugPrint("fss $levelP");
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
    }
  }

  onNextLevel(){
    level += 1;
    num.value = level.value >= 2 ? 6 : 10;
    setUpQuestion();
    isFinish.value = false;
  }

  restartGame(){
    index.value = 0;
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

}
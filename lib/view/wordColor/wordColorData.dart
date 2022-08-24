import 'package:flutter/material.dart';
import 'package:trainyourbrain/model/wordCOlorModel.dart';
import 'package:trainyourbrain/helper/constants.dart';
import 'package:trainyourbrain/model/wordColorOptionalModel.dart';


List<WordColorOptionalModel> wordColorModelOption = [
   WordColorOptionalModel(
       buttonTextName: blackName,
       colorHex: blackHexCode,),
   WordColorOptionalModel(
      buttonTextName: whiteName,
      colorHex: whiteHexCode,),
   WordColorOptionalModel(
      buttonTextName: greenName,
      colorHex: greenHexCode,),
];

List<WordColorModel> wordColorModel = [
   WordColorModel(
      questionTex: blackName,
      questionTextColor: blackHexCode,
      correctColor: greenHexCode,
      optionModel: wordColorModelOption
   ),
   WordColorModel(
       questionTex: whiteName,
       questionTextColor: whiteHexCode,
       correctColor: blackHexCode,
       optionModel: wordColorModelOption
   ),
   WordColorModel(
       questionTex: greenName,
       questionTextColor: greenHexCode,
       correctColor: whiteHexCode,
       optionModel: wordColorModelOption
   ),
   WordColorModel(
       questionTex: silverName,
       questionTextColor: silverHexCode,
       correctColor: grayHexCode,
       optionModel: getWordColorOptionModelData(grayName, grayHexCode, 3)
   ),
   WordColorModel(
       questionTex: grayName,
       questionTextColor: grayHexCode,
       correctColor: maroonHexCode,
       optionModel: getWordColorOptionModelData(maroonName, maroonHexCode, 3)
   ),
   WordColorModel(
       questionTex: redName,
       questionTextColor: redHexCode,
       correctColor: yellowHexCode,
       optionModel: getWordColorOptionModelData(yellowName, yellowHexCode, 3)
   ),
   WordColorModel(
       questionTex: purpleName,
       questionTextColor: purpleHexCode,
       correctColor: redHexCode,
       optionModel: getWordColorOptionModelData(redName, redHexCode, 3)
   ),
   WordColorModel(
       questionTex: yellowName,
       questionTextColor: yellowHexCode,
       correctColor: whiteHexCode,
       optionModel: getWordColorOptionModelData(whiteName, whiteHexCode, 3)
   ),
   WordColorModel(
       questionTex: blueName,
       questionTextColor: blueHexCode,
       correctColor: purpleHexCode,
       optionModel: getWordColorOptionModelData(purpleName, purpleHexCode, 3)
   ),
   WordColorModel(
       questionTex: navyName,
       questionTextColor: navyHexCode,
       correctColor: blueHexCode,
       optionModel: getWordColorOptionModelData(blueName, blueHexCode, 3)
   ),
   WordColorModel(
       questionTex: maroonName,
       questionTextColor: maroonHexCode,
       correctColor: yellowHexCode,
       optionModel: getWordColorOptionModelData(yellowName, yellowHexCode, 3)
   ),
];

getDataList(){
   return wordColorModel;
}

getWordColorModelData(int num){
   List<WordColorModel> levelAndKindList = [];
   List<WordColorModel> wordColorModelData = getDataList();
   wordColorModelData.shuffle();
   if(num > wordColorModelData.length){
      num = wordColorModelData.length;
   }
   for (int i = 0; i < num; i++) {
      levelAndKindList.add(wordColorModelData[i]);
   }
   levelAndKindList.shuffle();
   return levelAndKindList;
}

List<WordColorOptionalModel> getWordColorOptionModelData(correctColorName, correctColorHexCode, optionLen){
   List<WordColorOptionalModel> wordColorModelOption = [];
   WordColorOptionalModel data = WordColorOptionalModel(
      buttonTextName: correctColorName,
      colorHex: correctColorHexCode,);
   wordColorModelOption.add(data);
   for (int i = 0; i < optionLen - 1; i++) {
      if(getColorName[i] != correctColorName){
         WordColorOptionalModel data2 = WordColorOptionalModel(
            buttonTextName: getColorName[i],
            colorHex: getColorName[i],);
         wordColorModelOption.add(data2);
      }else{
         WordColorOptionalModel data2 = WordColorOptionalModel(
            buttonTextName: getColorName[i+1],
            colorHex: getColorName[i+1],);
         wordColorModelOption.add(data2);
      }
   }

   wordColorModelOption.shuffle();
   return wordColorModelOption;
}

ifSameColor(i){
   var color = getColorName;
   var colorHax = getColorHaxCode;
   color.shuffle();
   colorHax.shuffle();
   WordColorOptionalModel data2 = WordColorOptionalModel(
      buttonTextName: color[i],
      colorHex: colorHax[i],);
   if(wordColorModelOption.contains(data2)){
      return data2;
   }
   return null;
}
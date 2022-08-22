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
      questionTextColor: greenHexCode,
      correctColor: greenHexCode,
      optionModel: wordColorModelOption
   ),
   WordColorModel(
       questionTex: whiteName,
       questionTextColor: blackHexCode,
       correctColor: blackHexCode,
       optionModel: wordColorModelOption
   ),
   WordColorModel(
       questionTex: greenName,
       questionTextColor: whiteHexCode,
       correctColor: whiteHexCode,
       optionModel: wordColorModelOption
   ),
   WordColorModel(
       questionTex: silverName,
       questionTextColor: grayHexCode,
       correctColor: grayHexCode,
       optionModel: getWordColorOptionModelData(grayName, grayHexCode, 3)
   ),
   WordColorModel(
       questionTex: grayName,
       questionTextColor: maroonHexCode,
       correctColor: maroonHexCode,
       optionModel: getWordColorOptionModelData(maroonName, maroonHexCode, 3)
   ),
   WordColorModel(
       questionTex: redName,
       questionTextColor: yellowHexCode,
       correctColor: yellowHexCode,
       optionModel: getWordColorOptionModelData(yellowName, yellowHexCode, 5)
   ),
   WordColorModel(
       questionTex: purpleName,
       questionTextColor: redHexCode,
       correctColor: redHexCode,
       optionModel: getWordColorOptionModelData(redName, redHexCode, 5)
   ),
   WordColorModel(
       questionTex: yellowName,
       questionTextColor: whiteHexCode,
       correctColor: whiteHexCode,
       optionModel: getWordColorOptionModelData(whiteName, whiteHexCode, 3)
   ),
   WordColorModel(
       questionTex: blueName,
       questionTextColor: purpleHexCode,
       correctColor: purpleHexCode,
       optionModel: getWordColorOptionModelData(purpleName, purpleHexCode, 5)
   ),
   WordColorModel(
       questionTex: navyName,
       questionTextColor: blueHexCode,
       correctColor: blueHexCode,
       optionModel: getWordColorOptionModelData(blueName, blueHexCode, 3)
   ),
   WordColorModel(
       questionTex: maroonName,
       questionTextColor: yellowHexCode,
       correctColor: yellowHexCode,
       optionModel: getWordColorOptionModelData(yellowName, yellowHexCode, 5)
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
      }
   }
   wordColorModelOption.shuffle();
   return wordColorModelOption;
}
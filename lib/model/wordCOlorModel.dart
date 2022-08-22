import 'package:trainyourbrain/model/wordColorOptionalModel.dart';

class WordColorModel {
  WordColorModel({
    this.questionTex,
    this.questionTextColor,
    this.correctColor,
    this.optionModel
  });

  String? questionTex;
  String? questionTextColor;
  String? correctColor;
  List<WordColorOptionalModel>?  optionModel;

  factory WordColorModel.fromJson(Map<String, dynamic> json) => WordColorModel(
    questionTex: json["questionTex"],
    questionTextColor: json["questionTextColor"],
    correctColor: json["correctColor"],
    optionModel: List<WordColorOptionalModel>.from(json["optionModel"].map((x) => WordColorOptionalModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questionTex": questionTex,
    "questionTextColor": questionTextColor,
    "correctColor": correctColor,
    "WordColorOptionalModel": optionModel
  };
}



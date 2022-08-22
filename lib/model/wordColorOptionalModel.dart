class WordColorOptionalModel {
  WordColorOptionalModel({
    this.buttonTextName,
    this.colorHex,
  });

  String? buttonTextName;
  String? colorHex;

  factory WordColorOptionalModel.fromJson(Map<String, dynamic> json) => WordColorOptionalModel(
    buttonTextName: json["buttonTextName"],
    colorHex: json["colorHex"],
  );

  Map<String, dynamic> toJson() => {
    "questionTex": buttonTextName,
    "questionTextColor": colorHex,
  };
}
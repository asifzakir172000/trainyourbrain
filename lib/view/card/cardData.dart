import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:trainyourbrain/helper/image.dart';

enum Level { Hard, Medium, Easy }

List<String> fillSourceArray() {
  return [
    dioImage,
    foxImage,
    dogImage,
    whaleImage,
    bird1Image,
    bird2Image,
    cowImage,
    elephantImage,
    lionImage,
    pandaImage,
    saImage,
    sharkImage,
    snackImage,
  ];
}

// List<String> fillSourceArray() {
//   return [
//     dioImage,
//     dioImage,
//     foxImage,
//     foxImage,
//     dogImage,
//     dogImage,
//     whaleImage,
//     whaleImage,
//     bird1Image,
//     bird1Image,
//     bird2Image,
//     bird2Image,
//     cowImage,
//     cowImage,
//     elephantImage,
//     elephantImage,
//     lionImage,
//     lionImage,
//     pandaImage,
//     pandaImage,
//     saImage,
//     saImage,
//     sharkImage,
//     sharkImage,
//     snackImage,
//     snackImage,
//   ];
// }

List<String> getSourceArray(int num) {
  List<String> levelAndKindList = [];
  List sourceArray = fillSourceArray();
  sourceArray.shuffle();
  for (int i = 0; i < num/2; i++) {
    levelAndKindList.add(sourceArray[i]);
    levelAndKindList.add(sourceArray[i]);
  }

  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> getInitialItemState(int num) {
  List<bool> initialItemState = [];
  for (int i = 0; i < num; i++) {
    initialItemState.add(true);
  }
  return initialItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(int num) {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  for (int i = 0; i < num; i++) {
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}

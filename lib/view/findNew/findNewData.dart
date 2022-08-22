
import 'package:flutter/material.dart';
import 'package:trainyourbrain/helper/image.dart';

enum Level { Hard, Medium, Easy }

List<String> fillFindNewSourceArray() {
  return [
    dioImage,
    foxImage,
    dogImage,
    whaleImage,
    bird1Image,
    sharkImage,
  ];
}

List<String> fillFindNewShowArray() {
  return [
    bird2Image,
    cowImage,
    elephantImage,
    lionImage,
    pandaImage,
    saImage,
    snackImage,
  ];
}


List<String> getFindNewSourceArray(int num) {
  List<String> levelAndKindList = [];
  List sourceArray = fillFindNewSourceArray();
  sourceArray.shuffle();
  for (int i = 0; i < num; i++) {
    levelAndKindList.add(sourceArray[i]);
  }

  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<String> getFindNewShowItemState(int num, List<String> data) {
  List<String> initialItemState = [];
  List sourceArray = fillFindNewShowArray();
  sourceArray.shuffle();
  initialItemState.addAll(data);
  // int len = num >= 2 ? (num/2).round() : num;
  for (int i = 0; i < num; i++) {
    initialItemState.add(sourceArray[i]);
  }
  initialItemState.shuffle();
  return initialItemState;
}

List<bool> getFindNewSelectedItemState(int num) {
  List<bool> initialItemState = [];
  for (int i = 0; i < num; i++) {
    initialItemState.add(false);
  }
  return initialItemState;
}


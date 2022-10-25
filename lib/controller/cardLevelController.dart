import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/component/infoDialogBox.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/helper/utils.dart';

class CardLevelController extends GetxController{

  var level = 0.obs;

  checkLevel(index){
    var levelC = level.value + 1;
    if(index <= (levelC)){
      return true;
    }
    return false;
  }

  getLevel(){
    level.value = StorageKey.instance.getStorage(key: StorageKey.cop)??0;
  }

  show(context){
    Utils.instance.showCustomDialog(context, "", "", cardVideoJson);
  }

  void showCustomDialog(BuildContext context) {
    showInfoDialog(context, json: cardVideoJson, title: "Cards Of Pairs", des: "Memorize and find the pairs of cards as soon as possible");
  }

  @override
  void onInit() {
    getLevel();
    super.onInit();
  }

}
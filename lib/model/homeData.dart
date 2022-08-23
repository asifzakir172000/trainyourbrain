import 'package:get/get.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/view/card/cardLevel.dart';
import 'package:trainyourbrain/view/findNew/findNewLevel.dart';
import 'package:trainyourbrain/view/maza/mazeLevel.dart';
import 'package:trainyourbrain/view/wordColor/wordColorLevel.dart';

List<Map<String, dynamic>> reasoningData = [
  {
    "image": cardImage,
    "onTap": () {
      playAudio();
      Get.to(() => const CardLevel(), transition: Transition.rightToLeftWithFade);
    },
  },
  {
    "image": magnifyingGlass,
    "onTap": (){
      playAudio();
      Get.to(() => const FindNewLevel(), transition: Transition.rightToLeftWithFade);
    },
  },
  {
    "image": mazeHomeImage,
    "onTap": (){
      playAudio();
      Get.to(() => const MazeLevel(), transition: Transition.rightToLeftWithFade);
    },
  },
];

List<Map<String, dynamic>> attention = [
  {
    "image": wordColorGame,
    "onTap": (){
      playAudio();
      Get.to(() => const WordColorLevel(), transition: Transition.rightToLeftWithFade);
    },
  },
];


playAudio(){
  AudioPlayerClass.instance.play(beepAudio);
}
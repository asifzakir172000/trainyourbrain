
import 'package:get/get.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/view/home.dart';

class SplashScreenController extends GetxController{

  splashSetup(){
    AudioPlayerClass.instance.playBg(bgAudio);
    Future.delayed(const Duration(milliseconds: 7000), (){
      Get.offAll(()=>const HomePage(), transition: Transition.rightToLeftWithFade,);
    });
  }

  @override
  void onInit() {
    splashSetup();
    super.onInit();
  }

}
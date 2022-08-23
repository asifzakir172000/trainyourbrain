import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:video_player/video_player.dart';

class CardLevelController extends GetxController{

  var level = 0.obs;
  late VideoPlayerController controller;

  checkLevel(index){
    var levelC = level.value + 1;
    if(index <= (levelC)){
      return true;
    }else{
      Get.defaultDialog(
          title: "Complete the $levelC level first \nthan you can Play $index Level.",
          middleText: "",
          backgroundColor: Colors.white,
          middleTextStyle: const TextStyle(color: Colors.black),
          radius: 20,
          textCancel: "OK",
      );
    }
    return false;
  }

  getLevel(){
    level.value = StorageKey.instance.getStorage(key: StorageKey.cop)??0;
  }

  void showCustomDialog(BuildContext context, title, des) {
    setVideo();
    showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 38,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'HOW TO PLAY',
                  style: TextStyle(
                      fontSize: 28,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: VideoPlayer(controller),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  des,
                  style: const TextStyle(
                      fontSize: 28,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),

            ],
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  setVideo(){
    controller = VideoPlayerController.asset('assets/audio/file.mp4');
    controller.initialize();
    controller.play();
    controller.setLooping(true);
    controller.setVolume(0.0);
  }

  @override
  void onInit() {
    getLevel();
    super.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}
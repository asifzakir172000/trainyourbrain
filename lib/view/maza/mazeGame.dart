import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:maze/maze.dart';
import 'package:trainyourbrain/component/timeCountDown.dart';
import 'package:trainyourbrain/controller/findPathLevelController.dart';
import 'package:trainyourbrain/controller/mazeController.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';

class MazeGame extends StatefulWidget {
  const MazeGame({Key? key}) : super(key: key);

  @override
  State<MazeGame> createState() => _MazeGameState();
}

class _MazeGameState extends State<MazeGame>{

  MazeController mController = Get.put(MazeController());

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return mController.isFinished.value
          ? Scaffold(
        body: Center(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Lottie.asset(congrats),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(mController.level.value == 5 ? rabbitFinishJson : rabbitAndCarrot),
                  Text(
                    mController.isComplete.value
                        ? "Congratulations You completed all level"
                        : mController.isRetry.value ? "Game Over!!\nYou lost the Game" : "You win the Game!!\nCongratulations",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
              Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: mController.isComplete.value || mController.isRetry.value ? GestureDetector(
                    onTap: () {
                      mController.onRestartGame();
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade300,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      margin: const EdgeInsets.only(right: 30, left: 30),
                      child: const Icon(Icons.replay, color: Colors.white, size: 28,),
                    ),
                  ) : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          mController.onRestartGame();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.amber.shade300,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Icon(Icons.replay, color: Colors.white, size: 28,),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          mController.nextLevel(mController.level.value);
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .5,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.amber.shade300,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Icon(Icons.arrow_forward, color: Colors.white, size: 28,),
                        ),
                      ),
                    ],
                  ),),
            ],
          ),
        ),
      )
          : Scaffold(
        backgroundColor: Colors.amber.shade400,
        body: WillPopScope(
          onWillPop: ()async{
            AudioPlayerClass.instance.dismiss();
            Get.back();
            return false;
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.only(left: 10, right: 10), child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          margin: const EdgeInsets.only(top: 10, left: 10, ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(13),
                              boxShadow: const[
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(6, 6),
                                    blurRadius: 35,
                                    spreadRadius: 0.5),
                              ]
                          ),
                          child: const Icon(Icons.grid_view_rounded, color: Colors.amber,),
                        ),
                      ),
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
                              'Level ${mController.level.value}',
                              style: const TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber),
                            ),
                          ),
                        ),
                      ),
                      mController.start.value ? const SizedBox() : Padding(
                          padding: const EdgeInsets.only(top: 10, right: 10),
                        child: GestureDetector(
                          onTap: (){

                            Get.find<FindPathLevelController>().showCustomDialog(context);
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: const[
                                  BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(6, 6),
                                      blurRadius: 35,
                                      spreadRadius: 0.5),
                                ]
                            ),
                            child: const Icon(Icons.question_mark, color: Colors.amber,),
                          ),
                        ),
                      )
                    ],
                  ),),
                  Obx((){
                    return mController.start.value ? TimeCountDown(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 2,
                    ) : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10,),
                          child: CircularCountDownTimer(
                            width: 50,
                            height: 50,
                            duration: mController.timeLimits.value,
                            fillColor: Colors.amber.shade400,
                            ringColor: Colors.white,
                            backgroundColor: Colors.amber.shade400,
                            strokeWidth: 5.0,
                            isReverse: true,
                            strokeCap: StrokeCap.round,
                            textFormat: CountdownTextFormat.S,
                            isTimerTextShown: true,
                            textStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            onStart: () {

                            },
                            onComplete: () {
                                mController.isFinish();
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10,),
                          child: Maze(
                            height: MediaQuery.of(context).size.height * .8,
                              player: MazeItem(
                                  rabbitImage,
                                  ImageType.asset),
                              columns: mController.columns.value,
                              rows: mController.rows.value,
                              wallThickness: 4.0,
                              wallColor: Colors.white,
                              finish: MazeItem(
                                  mController.level.value == 5 ? riceCakeImage :carrotImage,
                                  ImageType.asset),
                              onFinish: () => mController.onFinishGame()),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    }) ;
  }
}


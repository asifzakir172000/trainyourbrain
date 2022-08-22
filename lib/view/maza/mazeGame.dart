import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:maze/maze.dart';
import 'package:trainyourbrain/controller/findNewController.dart';
import 'package:trainyourbrain/controller/mazeController.dart';
import 'package:trainyourbrain/helper/image.dart';

class MazeGame extends StatefulWidget {
  const MazeGame({Key? key}) : super(key: key);

  @override
  State<MazeGame> createState() => _MazeGameState();
}

class _MazeGameState extends State<MazeGame> {

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
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "You win the Game!!\nCongratulations",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.amber),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Row(
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
                            color: Colors.amber,
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
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: const Icon(Icons.arrow_forward, color: Colors.white, size: 28,),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      )
          : Scaffold(
        backgroundColor: Colors.amber,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Catch the carrot",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Obx((){
                  debugPrint("mController.columns.value ${mController.columns.value}");
                  debugPrint("mController.columns.value ${mController.rows.value}");
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Maze(
                        player: MazeItem(
                            rabbitImage,
                            ImageType.asset),
                        columns: mController.columns.value,
                        rows: mController.rows.value,
                        wallThickness: 4.0,
                        wallColor: Colors.white,
                        finish: MazeItem(
                            carrotImage,
                            ImageType.asset),
                        onFinish: () => mController.onFinishGame()),
                  );
                }),
              ],
            ),
          ),
        ),
      );
    }) ;
  }
}


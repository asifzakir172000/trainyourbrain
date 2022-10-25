import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trainyourbrain/component/timeCountDown.dart';
import 'package:trainyourbrain/controller/findNewController.dart';
import 'package:trainyourbrain/controller/findNewLevelController.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';

class FindNewGame extends StatefulWidget {
  const FindNewGame({Key? key}) : super(key: key);

  @override
  State<FindNewGame> createState() => _FindNewGameState();
}

class _FindNewGameState extends State<FindNewGame> {

  FindNewController mController = Get.put(FindNewController());

  Widget getItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 3,
                spreadRadius: 0.8,
                offset: Offset(2.0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(4.0),
        child: Image.asset(mController.data[index]),
      ),
    );
  }

  Widget getShowItem(int index) {
    return Obx(()=>GestureDetector(
      onTap: () => mController.onNewItemCheck(index),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 3,
                spreadRadius: 0.8,
                offset: Offset(2.0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: mController.isSelected[index] ? Colors.lightGreen : Colors.white,
                width: 3.0
            ),
          ),
          margin: const EdgeInsets.all(4.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(mController.showData[index]),
              ),
              Obx(() => Visibility(visible: mController.inCorrectIndex.contains(index), child: Image.asset(crossMarkImage),),),
              Obx(() => Visibility(visible: mController.correctIndex.contains(index), child: Image.asset(checkMarkImage),),)
            ],
          ),
        ),
      ),
    ));
  }

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
              Align(
                alignment: Alignment.center,
                child: Text(
                  mController.isComplete.value ? "You win the Game!!\nCongratulations\nCongratulations You completed all level"
                      : mController.isCorrectCount.value < mController.showCardLen.value ? "You can do it better!" : "Congratulations\nYou complete level",textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.amber),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: mController.isComplete.value ? GestureDetector(
                    onTap: () {
                      mController.restartGame();
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
                          mController.restartGame();
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
                          mController.onNextLevel(mController.level.value);
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
                  )),
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
                          AudioPlayerClass.instance.dismiss();
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
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 10, ),
                        child: mController.start.value
                            ? const TimeCountDown()
                            : GestureDetector(
                          onTap: (){
                            Get.find<FindNewLevelController>().showCustomDialog(context);
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
                      ),
                    ],
                  ),),
                  Obx((){
                    return mController.start.value ? Padding(
                      padding: const EdgeInsets.only(top:40, left: 20, right: 20, bottom: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => getItem(index),
                        itemCount: mController.data.length,
                      ),
                    ) : Padding(
                      padding: const EdgeInsets.only(top:40, left: 20, right: 20, bottom: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => getShowItem(index),
                        itemCount: mController.showData.length,
                      ),
                    ) ;
                  }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

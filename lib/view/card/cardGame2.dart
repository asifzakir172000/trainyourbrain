import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:trainyourbrain/component/timeCountDown.dart';
import 'package:trainyourbrain/controller/cardFlipController.dart';
import 'package:trainyourbrain/controller/cardLevelController.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/model/homeData.dart';

class FlipCardTwoScreen extends StatefulWidget {

  const FlipCardTwoScreen({Key? key}) : super(key: key);

  @override
  State<FlipCardTwoScreen> createState() => _FlipCardScreenState();
}

class _FlipCardScreenState extends State<FlipCardTwoScreen> {

  CardFlipController mController = Get.put(CardFlipController());

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
        margin: const EdgeInsets.all(4.0),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(mController.data[index]),
            ),
            Obx(() => Visibility(visible: !mController.cardFlips[index], child: Image.asset(checkMarkImage),),)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return mController.isFinished.value
          ? Scaffold(
        body: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 500),
          child: Center(
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Lottie.asset(congrats),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    mController.isComplete.value ? "Congratulations You completed all level" : "You Won the Game!!\nCongratulations",
                    textAlign: TextAlign.center,
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
                        mController.restart();
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
                    ) :  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            mController.restart();
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
                    )),
              ],
            ),
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
                            Get.find<CardLevelController>().showCustomDialog(context);
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
                    return !mController.start.value
                        ? Column(
                          children: [
                            TweenAnimationBuilder<Duration>(
                                duration: const Duration(minutes: 15),
                                tween: Tween(begin: Duration.zero, end: const Duration(minutes: 15)),
                                builder: (BuildContext context, Duration value, Widget? child) {
                                  final minutes = value.inMinutes <= 9 ? "0${value.inMinutes}" : "${value.inMinutes}";
                                  final  seconds = (value.inSeconds % 60) <= 9 ? "0${value.inSeconds % 60}" : "${value.inSeconds % 60}";
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      '$minutes:$seconds',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),),);
                                }),
                            Padding(
                      padding: const EdgeInsets.only(top:20, left: 20, right: 20, bottom: 20),
                      child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) => FlipCard(
                                key: mController.cardStateKeys[index],
                                onFlip: () {
                                  /*if(mController.cardFlips[index]){

                                  }*/
                                  mController.onFlip(index);
                                },
                                speed: 100,
                                flipOnTouch: mController.cardFlips[index],
                                direction: FlipDirection.HORIZONTAL,
                                front: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3,
                                            spreadRadius: 0.8,
                                            offset: Offset(2.0, 1),
                                          )
                                        ]),
                                    margin: const EdgeInsets.only(left: 4.0, right: 4.0, top: 4.0, bottom: 4.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        questionMarkImage,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                back: getItem(index)),
                            itemCount: mController.data.length,
                      ),
                    ),
                          ],
                        ) : Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
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
    });
  }
}

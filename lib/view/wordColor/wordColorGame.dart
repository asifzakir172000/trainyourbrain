import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:trainyourbrain/component/shakeWidget.dart';
import 'package:trainyourbrain/controller/wordColorController.dart';
import 'package:trainyourbrain/controller/wordColorLevelController.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/model/homeData.dart';

class WordColorGame extends StatefulWidget {
  const WordColorGame({Key? key}) : super(key: key);

  @override
  State<WordColorGame> createState() => _WordColorGameState();
}

class _WordColorGameState extends State<WordColorGame> {

  WordColorController mController = Get.put(WordColorController());
  final shakeKey = GlobalKey<ShakeWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => mController.isFinish.value
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
                Lottie.asset(colorsJson),
                Text(
                  mController.isComplete.value ? "You win the Game!!\nCongratulations\nCongratulations You completed all level"
                      : mController.calculatePer() <= 30 ? "You can do it better!" : "Congratulations\nYou complete level",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.amberAccent),
                ),
                 Text(
                  "${mController.calculatePer()} / 100",
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
              left: mController.isComplete.value ? MediaQuery.of(context).size.width * .3 : 0,
              right: mController.isComplete.value ? MediaQuery.of(context).size.width * .3 : 0,
              child: SizedBox(
                child: mController.isComplete.value
                    ? GestureDetector(
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
                )
                    : Row(
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
                        mController.onNextLevel();
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
                ),
              ),
            ),
          ],
        ),
      ),
    )
        : Scaffold(
      backgroundColor: Colors.amber.shade400,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.only(left: 10, right: 10), child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    AudioPlayerClass.instance.play(beepAudio);
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
                Padding(padding: const EdgeInsets.only(top: 10, left: 10, ), child: GestureDetector(
                  onTap: (){
                    playAudio(beepAudio);
                    Get.find<WordColorLevelController>().showCustomDialog(context);
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
                ),)

              ],
            ),),
            const Spacer(),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(bgCloud),
                  fit: BoxFit.cover,
                ),
              ),
              child: ShakeWidget(
                // 4. pass the GlobalKey as an argument
                key: shakeKey,
                // 5. configure the animation parameters
                shakeCount: 3,
                shakeOffset: 10,
                shakeDuration: const Duration(milliseconds: 500),
                child: Center(
                  child: Stack(
                    children: [
                      // Implement the stroke
                      Text(
                        "${mController.questionText}",
                        style: TextStyle(
                          fontSize: 80,
                          letterSpacing: 5,
                          fontWeight: FontWeight.w900,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = mController.colorConvert(mController.borderColor.value),
                        ),
                      ),
                      // The text inside
                      Text("${mController.questionText}",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 80,
                          letterSpacing: 5,
                          color: mController.colorConvert(mController.colorToShow.value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0
              ),
              itemCount: mController.option.length,
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: (){
                    mController.onCheck(mController.option[index].colorHex, shakeKey);
                    },
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.white24,
                            Colors.white30,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(child: Text("${mController.option[index].buttonTextName}", style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 24
                    ),),),
                  ),
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    ),
    );
  }
}

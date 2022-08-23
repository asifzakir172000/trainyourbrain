import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:trainyourbrain/controller/wordColorController.dart';
import 'package:trainyourbrain/helper/image.dart';

class WordColorGame extends StatefulWidget {
  const WordColorGame({Key? key}) : super(key: key);

  @override
  State<WordColorGame> createState() => _WordColorGameState();
}

class _WordColorGameState extends State<WordColorGame> {

  WordColorController mController = Get.put(WordColorController());

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
                  mController.isComplete.value ? "Congratulations You completed all level" :  "You win the Game!!\nCongratulations",
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
                    child: Icon(Icons.grid_view_rounded, color: Colors.amber,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13),
                      // boxShadow: const[
                      //   BoxShadow(
                      //       color: Colors.white,
                      //       offset: Offset(6, 6),
                      //       blurRadius: 35,
                      //       spreadRadius: 0.5),
                      // ]
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
                const SizedBox()
              ],
            ),),
            Spacer(),
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
              child: Text("${mController.questionText}", style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 80,
                color: mController.colorConvert(mController.colorToShow.value),
              ),
              ),
            ),
            Spacer(),
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
                  onTap: (){mController.onCheck(mController.option[index].colorHex);},
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

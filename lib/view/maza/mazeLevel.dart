import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainyourbrain/controller/cardLevelController.dart';
import 'package:trainyourbrain/controller/findPathLevelController.dart';
import 'package:trainyourbrain/view/maza/mazeData.dart';
import 'package:trainyourbrain/view/maza/mazeGame.dart';

class MazeLevel extends StatefulWidget {
  const MazeLevel({Key? key}) : super(key: key);

  @override
  State<MazeLevel> createState() => _MazeLevelState();
}

class _MazeLevelState extends State<MazeLevel> {

  FindPathLevelController mController = Get.put(FindPathLevelController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/5,
            color: Colors.white,
            child:  ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                color: Colors.amber,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.back();
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
                        child: Icon(Icons.home, color: Colors.amber,),
                      ),
                    ),
                    Text("Find the path", style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none
                    ),),
                    GestureDetector(
                      onTap: (){
                        Get.back();
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
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * .05,
              ),
              Obx((){
                debugPrint(mController.level.value.toString());
                return GridView.builder(
                  padding:  const EdgeInsets.all(10),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){
                        var row = index <= 1 ? mazeData[index]["rows"] : Random().nextInt(10) + 10;
                        var column = index <= 1 ? mazeData[index]["column"] : Random().nextInt(10) + 10;
                        if(mController.checkLevel(index+1)) {
                          Get.to(() => const MazeGame(),
                              transition: Transition.rightToLeftWithFade,
                              arguments: {
                                "rows": row,
                                "columns": column,
                                "level": index + 1
                              });
                        }
                      },
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.grey,
                        color: mController.level.value > index ? Colors.green : Colors.amber,
                        child: Center(child: Text("${index + 1}", style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 24
                        ),),),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
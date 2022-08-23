import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainyourbrain/controller/findNewLevelController.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/helper/utils.dart';
import 'package:trainyourbrain/model/homeData.dart';
import 'package:trainyourbrain/view/findNew/findNewGame.dart';

class FindNewLevel extends StatefulWidget {
  const FindNewLevel({Key? key}) : super(key: key);

  @override
  State<FindNewLevel> createState() => _FindNewLevelState();
}

class _FindNewLevelState extends State<FindNewLevel> {

   FindNewLevelController mController = Get.put(FindNewLevelController());

   @override
   void initState() {
     super.initState();
     Future.delayed(const Duration(milliseconds: 500), (){
       final result = StorageKey.instance.getStorage(key: StorageKey.findNewFirst)??false;
       if(!result){
         StorageKey.instance.setStorage(key: StorageKey.findNewFirst, msg: true);
         mController.showCustomDialog(context);
       }
     });

   }

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
                color: Colors.amber.shade400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        playAudio(beepAudio);
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
                    Text("Find a New Card", style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none
                    ),),
                    GestureDetector(
                      onTap: (){
                        playAudio(beepAudio);
                        mController.showCustomDialog(context);
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
                        var num = index >= 2 ? 3 : 2;
                        var showCard = 1;
                        if(index >= 2 && index <= 3){
                          showCard = 2;
                        }else if(index >= 4 ){
                          showCard = 3;
                        }
                        playAudio(clickAudio);
                        if(mController.checkLevel(index+1)){
                          Get.to(() => const FindNewGame(), transition: Transition.rightToLeftWithFade, arguments: {
                            "num": num,
                            "showCard": showCard,
                            "level": index + 1
                          },);
                        }
                      },
                      child: Card(
                        elevation: 2,
                        shadowColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: mController.level.value > index ? Colors.green : Colors.amber, //<-- SEE HERE
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        color: mController.level.value > index ? Colors.lightGreen.shade100 : Colors.amber.shade300,
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

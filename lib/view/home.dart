
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/model/homeData.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget getCard({onPress, image}){
    return GestureDetector(
      onTap: onPress,
      child: Card(
        elevation: 8,
        shadowColor: Colors.grey[50]!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Image.asset(image, fit: BoxFit.fill,),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    AudioPlayerClass.instance.play(audioAsset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            child:  ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: MediaQuery.of(context).size.width/2,
                color: Colors.amber,
                child: Center(child: Text("Train your Brain", style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700
                ),),),
              ),
            ),
          ),

          //reasoning
          Container(
            margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
            padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 3,
                      spreadRadius: 0.8,
                      offset: const Offset(2.0, 1),
                    )
                  ],
                  borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  child: const Text(
                    "Reasoning",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.amber),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10.0),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0
                  ),
                  itemCount: reasoningData.length,
                  itemBuilder: (BuildContext context, int index){
                    return getCard(
                        image: reasoningData[index]["image"],
                        onPress: reasoningData[index]["onTap"]
                    );
                  },
                ),
              ],
            )
          ),

          //logical
          Container(
              margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 3,
                      spreadRadius: 0.8,
                      offset: const Offset(2.0, 1),
                    )
                  ],
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    child: const Text(
                      "Attention",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.amber),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10.0),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0
                    ),
                    itemCount: attention.length,
                    itemBuilder: (BuildContext context, int index){
                      return getCard(
                          image: attention[index]["image"],
                          onPress: attention[index]["onTap"]
                      );
                    },
                  ),
                ],
              )
          ),

          const Spacer(),
        ],
      ),
    );
  }
}

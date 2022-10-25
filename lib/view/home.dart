
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:trainyourbrain/controller/homeController.dart';
import 'package:trainyourbrain/helper/audioPlayer.dart';
import 'package:trainyourbrain/helper/image.dart';
import 'package:trainyourbrain/model/homeData.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeController mController = Get.put(HomeController());
  late BannerAd _bannerAd;
  String _isAdLoaded = "Loading";

  Widget getCard({onPress, image}){
    return GestureDetector(
      onTap: onPress,
      child: Card(
        elevation: 8,
        shadowColor: Colors.grey[50]!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: image == "Coming Soon" ? Container(
          alignment: Alignment.center,
          child: Text(
            "Coming\nSoon",
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntu(
                color: Colors.black,
                fontSize: 18,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w700
            ),
          ),
        ) : Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(image, fit: BoxFit.fill,),
        ),
      ),
    );
  }

  @override
  void initState() {
    AudioPlayerClass.instance.playBg(relaxAudio, false);
    _initAds();
    super.initState();
  }

  _initAds(){
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(
          onAdLoaded: (ad){
            setState((){
              _isAdLoaded = "Complete";
            });
          },
          onAdFailedToLoad: (ad, err){
            setState((){
              _isAdLoaded = "Error";
            });
          }
        ),
        request: AdRequest()
    );

    _bannerAd.load();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isAdLoaded == "Complete" ? SizedBox(
        height: _bannerAd.size.height.toDouble(),
        width: _bannerAd.size.width.toDouble(),
        child: AdWidget(
          ad: _bannerAd,
        ),
      ) : SizedBox(
        height: 40,
        child: Center(
          child: Text(_isAdLoaded=="Error" ? " " : "Ads Loading..."),
        ),
      ),
      body: Container(
        color: const Color(0xFFFBFCF8),
        child: Column(
          children: [
            SizedBox(
              child:  ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.width/2,
                  color: Colors.amber.shade400,
                  child: Center(child: Text("Brain Teasers", style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 40,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w700
                  ),),),
                ),
              ),
            ),

            Column(
              children: [
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
                                fontSize: 20,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500,
                                color: Colors.amber),
                          ),
                        ),
                        Obx(() => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: LinearPercentIndicator(
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent: mController.reasoningPer.value.toDouble(),
                            barRadius: const Radius.circular(16),
                            progressColor: Colors.amber.shade300,
                            backgroundColor: Colors.amber.shade100,
                          ),
                        ),),
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

                //Attention
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
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                                color: Colors.amber),
                          ),
                        ),
                        Obx(() => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: LinearPercentIndicator(
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent: mController.attentionPer.value.toDouble(),
                            barRadius: const Radius.circular(16),
                            progressColor: Colors.amber.shade300,
                            backgroundColor: Colors.amber.shade100,
                          ),
                        ),),
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
              ],
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

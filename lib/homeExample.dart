// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:trainyourbrain/controller/homeController.dart';
// import 'package:trainyourbrain/helper/image.dart';
// import 'package:trainyourbrain/view/card/cardLevel.dart';
// import 'package:trainyourbrain/view/findNew/findNewLevel.dart';
// import 'package:trainyourbrain/view/maza/mazeLevel.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   // HomeController mController = Get.put(HomeController());
//   late PageController pageController;
//   var currentPage = 0;
//
//   List<Map<String, dynamic>> homeCardData = [
//     {
//       "name": "Pairs Of Card",
//       "image": cardImage,
//       "onTap": (){
//         Get.to(() => const CardLevel(), transition: Transition.rightToLeftWithFade);
//       },
//     },
//     {
//       "name": "Find New Card",
//       "image": cardImage,
//       "onTap": (){
//         Get.to(() => const FindNewLevel(), transition: Transition.rightToLeftWithFade);
//       },
//     },
//     {
//
//       "name": "Maze",
//       "image": cardImage,
//       "onTap": (){
//         Get.to(() => const MazeLevel(), transition: Transition.rightToLeftWithFade);
//       },
//     },
//   ];
//
//
//   Widget getCard({onPress, image, name}){
//     return GestureDetector(
//       onTap: onPress,
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow:  [
//                 BoxShadow(
//                   color: Colors.grey[300]!,
//                   blurRadius: 5,
//                   spreadRadius: 0.8,
//                   offset: const Offset(2.0, 1),
//                 )
//               ],
//               borderRadius: BorderRadius.circular(25),
//             ),
//             child: Image.network(image, fit: BoxFit.cover, height: MediaQuery.of(context).size.height/8,),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 20),
//             child: Center(child: Text(name, style: GoogleFonts.ubuntu(
//                 color: Colors.amber,
//                 fontSize: 24
//             ),),),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   carouselView(index){
//     return AnimatedBuilder(
//         animation: pageController,
//         builder: (context, child) {
//           double value = 0.0;
//           if(pageController.position.haveDimensions){
//             value = index.toDouble() - (pageController.page ?? 0);
//             value = (value * 0.038).clamp(-1, 1);
//           }
//           return Transform.rotate(
//             angle: pi*value,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: getCard(
//                 image: homeCardData[index]["image"],
//                 onPress: homeCardData[index]["onTap"],
//                 name: homeCardData[index]["name"],
//               ),
//             ),);
//         }
//     );
//   }
//
//
//   @override
//   void initState() {
//     pageController = PageController(initialPage: currentPage, viewportFraction: 0.8);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: [
//             SizedBox(
//               child:  ClipPath(
//                 clipper: OvalBottomBorderClipper(),
//                 child: Container(
//                   height: MediaQuery.of(context).size.height/4,
//                   color: Colors.amber,
//                   child: Center(child: Text("Train your Brain", style: GoogleFonts.ubuntu(
//                       color: Colors.white,
//                       fontSize: 28
//                   ),),),
//                 ),
//               ),
//             ),
//             SafeArea(
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height/4,
//                 child: PageView.builder(
//                   itemCount: homeCardData.length,
//                   physics: const ClampingScrollPhysics(),
//                   controller: pageController,
//                   itemBuilder: (context, index){
//                     return carouselView(index);
//                   },
//                 ),
//               ),
//             ),
//             const Spacer(),
//           ],
//         ),
//       ),
//     );
//   }
// }

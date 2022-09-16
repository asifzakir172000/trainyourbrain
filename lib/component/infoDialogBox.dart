import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

void showInfoDialog(BuildContext context, {json, title, des}) {
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: MediaQuery.of(context).size.height * .15 , bottom: MediaQuery.of(context).size.height * .15),
        decoration: BoxDecoration(
          color: Colors.amber.shade400, // Set border width
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),), // Set rounded corner radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: Align(alignment: Alignment.topRight, child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const[
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(6, 6),
                            blurRadius: 35,
                            spreadRadius: 0.5),
                      ]
                  ),
                  child: const Icon(Icons.cancel_outlined, color: Colors.amber,),
                ),
              ),),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 28,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'HOW TO PLAY',
                style: TextStyle(
                    fontSize: 28,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.height / 4,
              child: Lottie.asset(json,
                fit: BoxFit.contain,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                des,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 28,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
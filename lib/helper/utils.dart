
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Utils {

  Utils._internal();
  static final Utils _instance = Utils._internal();
  static Utils get instance => _instance;

  void showCustomDialog(BuildContext context, title, des, json) {
    showGeneralDialog(
      context: context,
      transitionDuration: const Duration(milliseconds: 700),
      pageBuilder: (_, __, ___) {
        return Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
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
                      title,
                      style: const TextStyle(
                          fontSize: 38,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'HOW TO PLAY',
                  style: TextStyle(
                      fontSize: 28,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.height / 4,
                child: Lottie.asset(json,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  des,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 28,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
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

}
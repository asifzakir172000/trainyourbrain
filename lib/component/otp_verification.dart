import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/controller/login_controller.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/view/home.dart';

void showOTPDialog(BuildContext context, {controller, id}) {
  showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: MediaQuery.of(context).size.height * .15 , bottom: MediaQuery.of(context).size.height * .15),
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white, // Set border width
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),), // Set rounded corner radius
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(alignment: Alignment.topRight, child: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.amberAccent.withOpacity(.3),
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
              const Text(
                "OTP Verification",
                style: TextStyle(
                    fontSize: 28,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              //otp
              const SizedBox(height: 20,),
                const Text(
                  'OTP',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54),
                ),
              const SizedBox(height: 30,),
              const Text(
                'Enter OTP',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54),
              ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10,),
                  margin: const EdgeInsets.only(top: 10,),
                  decoration: BoxDecoration(
                    color: Colors.amberAccent.withOpacity(.4),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber),
                  ),
                  child: TextField(
                    onSubmitted: (newValue){},
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    maxLength: 6,
                    controller: controller,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        counterText: ""
                    ),
                  ),
                ),
              const Spacer(),
              InkWell(
                onTap: (){
                 if(id == "LoginButton"){
                   StorageKey.instance.setStorage(key: StorageKey.isLogin, msg: true);
                   Get.offAll(()=>const HomePage(), transition: Transition.rightToLeftWithFade,);
                 }else{
                   LoginController loginController = Get.find();
                   loginController.setOtpVerify(id);
                   Get.back();
                 }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10,),
                  margin: const EdgeInsets.only(top: 10,),
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
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
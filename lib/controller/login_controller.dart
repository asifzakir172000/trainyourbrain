
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/component/otp_verification.dart';

class LoginController extends GetxController{
  late TextEditingController otpController;
  var disable = false;
  var otpVerify = false;


  void showCustomDialog(BuildContext context, String id) {
    otpController.clear();
    showOTPDialog(context, controller: otpController, id: id);
  }

  buttonDisable(value, id){
    if(value.length == 10){
      disable = true;
    }else{
      disable = false;
    }
    update([id]);
  }

  setOtpVerify(id){
    otpVerify = !otpVerify;
    disable = true;
    update([id]);
  }


  buttonDisableClear(){
    disable = false;
    update();
  }


  @override
  void onInit() {
    otpController = TextEditingController(text: "");
    super.onInit();
  }


  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }

}
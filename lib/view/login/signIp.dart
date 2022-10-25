import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/helper/storageKey.dart';
import 'package:trainyourbrain/view/home.dart';

import '../../controller/login_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late TextEditingController _editingController;
  late TextEditingController _phoneController;
  final loginController = Get.put(LoginController());
  final focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: "");
    _phoneController = TextEditingController(text: "");
  }
  @override
  void dispose() {
    _editingController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          color: const Color(0xFFFBFCF8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  print("sign up back");
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10, ),
                  decoration: BoxDecoration(
                      color: Colors.amberAccent.withOpacity(.4),
                      borderRadius: BorderRadius.circular(90),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.amber.withOpacity(.1),
                            offset: const Offset(3, 3),
                            blurRadius: 35,
                            spreadRadius: 0.5),
                      ]
                  ),
                  child: const Icon(Icons.arrow_back_ios, color: Colors.amber,),
                ),
              ),

              const SizedBox(height: 20,),

              const Text(
                'Create',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),

              const Text(
                'Account',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),

              //name
              const SizedBox(height: 60,),
              const Text(
                'Your Name',
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
                  autofocus: false,
                  controller: _editingController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),

              //phone number
              const SizedBox(height: 20,),
              const Text(
                'Your Phone number',
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
                  onChanged: (newValue){
                    print(newValue);
                    print(newValue.length);
                    if(newValue.length == 10){
                      loginController.showCustomDialog(context, "RegButton");
                    }
                  },
                  keyboardType: TextInputType.number,
                  focusNode: focus,
                  maxLength: 10,
                  controller: _phoneController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: ""
                  ),
                ),
              ),



              //button
              const Spacer(),
              GetBuilder<LoginController>(
                  id: "RegButton",
                  builder: (ctx) {
                    return InkWell(
                      onTap: ctx.disable ? (){
                        if(_editingController.text.isNotEmpty && _editingController.text.length >= 3){
                          StorageKey.instance.setStorage(key: StorageKey.isLogin, msg: true);
                          Get.offAll(()=>const HomePage(), transition: Transition.rightToLeftWithFade,);
                        }else{
                          Get.snackbar(
                            "Please Enter Name",
                            "Name should not be empty and name length must be greater than 2.",
                            icon: const Icon(Icons.error, color: Colors.white),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.black54,
                            colorText: Colors.white
                          );
                        }
                      } : null,
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(left: 10,),
                        margin: const EdgeInsets.only(top: 10,),
                        decoration: BoxDecoration(
                          color: ctx.disable? Colors.amberAccent : Colors.grey.shade200,
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
                    );
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}

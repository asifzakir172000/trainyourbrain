import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/view/login/signIp.dart';

import '../../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _editingController;
  late TextEditingController _phoneController;
  final loginController = Get.put(LoginController());
  final focus = FocusNode();
  bool? checkedValue = false;

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              const SizedBox(height: 40,),

              const Text(
                'Login',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              const SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an Account? ',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54),
                  children: <TextSpan> [
                    TextSpan(
                        text: 'Register',
                        recognizer: TapGestureRecognizer()..onTap = () {
                          loginController.buttonDisableClear();
                           Get.to(()=>const SignInScreen(), transition: Transition.rightToLeftWithFade,);
                          } ,
                        style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Colors.amber,
                      fontSize: 16,
                      decorationStyle: TextDecorationStyle.dotted,
                    )
                    ),
                  ]
                ),
              ),


              //phone number
              const SizedBox(height: 70,),
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
                    // print(newValue);
                    // print(newValue.length);
                    if(newValue.length == 10){
                      loginController.buttonDisable(newValue, "LoginButton");
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

              //18 check box
              /*CheckboxListTile(
                title: const Text("18 year above"),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),*/
              InkWell(
                onTap: (){
                  setState(() {
                    checkedValue = !checkedValue!;
                  });
                },
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.amber,
                      value: checkedValue,
                      onChanged: (bool? value) {
                        setState(() {
                          checkedValue = value!;
                        });
                      },
                    ),
                    const Text("18 year above"),
                  ],
                ),
              ),



              //button
              const Spacer(),
              GetBuilder<LoginController>(
                id: "LoginButton",
                builder: (ctx) {
                  return InkWell(
                    onTap: ctx.disable ? (){
                      if(_phoneController.text.length == 10){
                        loginController.showCustomDialog(context, "LoginButton");
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

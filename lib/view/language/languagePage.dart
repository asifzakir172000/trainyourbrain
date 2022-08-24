import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trainyourbrain/component/selectBox.dart';
import 'package:trainyourbrain/controller/languageController.dart';
import 'package:trainyourbrain/view/language/languageData.dart';

class LanguagePage extends StatelessWidget {
  LanguagePage({Key? key}) : super(key: key);
  final LanguageController controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber.shade400,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 1.4,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      "choose".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white , fontSize:28, fontWeight: FontWeight.w500),) ,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "your_language".tr,
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.white , fontSize:28),) ,
                  ),
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 8.0),
                      itemCount: languageData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(
                              () => GestureDetector(
                            onTap: () => {
                              controller.setIndex(index),
                              controller.updateLanguage(languageData[index]["langCode"], "IN"),
                            },
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: controller.counter.value == index
                                  ? Container(
                                key: const ValueKey(1),
                                child: SelectBox(
                                  language: languageData[index]["name"],
                                ),
                              )
                                  : Container(
                                key: const ValueKey(2),
                                child: UnSelectBox(
                                  language: languageData[index]["name"],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

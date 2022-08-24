import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {

  var counter = 0.obs;

  setIndex(index) {
    counter.value = index;
  }

  updateLanguage(languageCode, countryCode) {
    var locale = Locale(languageCode, countryCode);
    Get.updateLocale(locale);
  }
}

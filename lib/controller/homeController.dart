import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  late PageController pageController;
  var currentPage = 0.obs;

  @override
  void onInit() {
    pageController = PageController(initialPage: currentPage.value, viewportFraction: 0.8);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

}
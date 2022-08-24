import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trainyourbrain/view/language/languagekey.dart';
import 'package:trainyourbrain/view/splash.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Test your Brain',
      debugShowCheckedModeBanner: false,
      translations: LanguageKey(),
      locale: const Locale('en', 'US'),
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: SplashScreen(),
    );
  }
}

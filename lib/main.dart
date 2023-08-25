import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/view/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: SplashScreen(),
    );
  }
}

// This ling comma makes auto-formatting nicer for build methods.
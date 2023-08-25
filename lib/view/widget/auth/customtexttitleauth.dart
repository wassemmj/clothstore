import 'package:flutter/material.dart';

class CustomTitleTextAuth extends StatelessWidget {
  const CustomTitleTextAuth({Key? key,
    required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title,textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 40,
        fontFamily: "Pacifico",
        color: Colors.white,
        fontWeight: FontWeight.bold,

      ),);
  }
}

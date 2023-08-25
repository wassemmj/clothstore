


import 'package:flutter/material.dart';

class CustomBodyTextAuth extends StatelessWidget {
  final String textbody;
  const CustomBodyTextAuth({Key? key, required this.textbody}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(textbody,textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 15,
          fontFamily: "Pacifico",
          color: Colors.white,
          fontWeight: FontWeight.w100

      ),);
  }
}


import 'package:flutter/material.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final void Function() ontap;
  const  CustomButtonAuth({Key? key, required this.text,required this.ontap, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 70,
        height: 56,
        margin: EdgeInsets.symmetric(horizontal: 90) ,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.deepPurple,Colors.white
                ]),
            borderRadius: BorderRadius.circular(40)),
        child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: "Pacifico",
              ),
            )),
      ),
    );
  }
}

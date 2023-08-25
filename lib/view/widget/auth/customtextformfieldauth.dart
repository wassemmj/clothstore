import 'package:flutter/material.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;
  final IconData iconData;
  final TextEditingController? mycontroller;
final bool? obscureText =true ;

  const CustomTextFormAuth(
      {Key? key,
      required this.hinttext,
      required this.iconData,
      required this.mycontroller, required bool obscureText,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(),
      child: TextFormField(
        controller: mycontroller,

        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle:
              const TextStyle(color: Colors.grey, fontFamily: "Pacifico"),
          suffixIcon: Icon(
            iconData,
            color: Colors.deepPurple,
          ),
          border: InputBorder.none,
        ),
        cursorColor: const Color.fromRGBO(143, 148, 251, 1),
      ),
    );
  }
}

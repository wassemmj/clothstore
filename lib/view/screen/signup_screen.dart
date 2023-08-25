import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/core/constant/token.dart';
import 'package:myproject/view/screen/home_screen.dart';
import 'package:myproject/view/widget/auth/customtextformfieldauth.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:http/http.dart' as http;

import 'Loginscreen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController(text: 'gh');
  final fullNameController = TextEditingController(text: 'gh');
  final emailController = TextEditingController(text: 'ghina@gmail.com');
  final passwordController = TextEditingController(text: '123456789v!');
  final coPasswordController = TextEditingController(text: '123456789v!');
  String phoneCo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/light-1.png'))),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/light-2.png'))),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/clock.png'))),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text(
                            "SignUp",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Pacifico"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: CustomTextFormAuth(
                              hinttext: "Enter user name ...",
                              iconData: Icons.person,
                              mycontroller: nameController,
                              obscureText: false,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: CustomTextFormAuth(
                              hinttext: "Enter your fully name ...",
                              iconData: Icons.person,
                              mycontroller: fullNameController,
                              obscureText: false,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: CustomTextFormAuth(
                              hinttext: "Enter your email ...",
                              iconData: Icons.email_outlined,
                              mycontroller: emailController,
                              obscureText: false,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: CustomTextFormAuth(
                              hinttext: "Enter your password",
                              iconData: Icons.lock_outlined,
                              mycontroller: passwordController,
                              obscureText: true,
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey))),
                            child: CustomTextFormAuth(
                              hinttext: "Enter your confirm password",
                              iconData: Icons.lock_outlined,
                              mycontroller: coPasswordController,
                              obscureText: true,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(),
                            child: IntlPhoneField(
                              initialValue: '+963',
                              disableLengthCheck: true,
                              autovalidateMode: AutovalidateMode.disabled,
                              onChanged: (phone) {
                                phoneCo = phone.completeNumber;
                              },
                              decoration: const InputDecoration(
                                hintText: 'Enter Your phone number',
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontFamily: "Pacifico"),
                                suffixIcon: Icon(
                                  Icons.phone,
                                  color: Colors.deepPurple,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () => onPressed(context),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ])),
                        child: const Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Pacifico"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "have an account?",
                          style: TextStyle(
                            color: Colors.black45,
                            fontFamily: "Pacifico",
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.to(loginscreen(),
                                  transition: Transition.cupertino,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeIn);
                            },
                            child: const Text(
                              'login',
                              style: TextStyle(
                                color: Color.fromRGBO(143, 148, 251, 1),
                                fontFamily: "Pacifico",
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future onPressed(BuildContext context) async {
      var response = await http.post(Uri.parse('http://192.168.43.184:8000/api/register'), headers: {
        'Accept': 'application/json'
      }, body: {
        'email': emailController.text,
        'FullName': fullNameController.text,
        'UserName': nameController.text,
        'phoneNumber': phoneCo,
        'Address': 'jggjgukhjhkh',
        'password': passwordController.text,
        'password_confirmation': coPasswordController.text,});
      if (response.statusCode == 200) {
        var hg = jsonDecode(response.body);
        Token.token = hg['token'];
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'register successfully',
          style: TextStyle(
            fontFamily: "Pacifico",
          ),
        ),
        ),
        );
        Get.to(const HomeScreen(),
            transition: Transition.topLevel,
            duration: const Duration(seconds: 1),
            curve: Curves.easeIn,
        );
      }
      else {
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          'try again, an error occurred',
          style: TextStyle(
            fontFamily: "Pacifico",
          ),
        ),
        ),
        );
      }
  }
}

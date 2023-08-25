import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myproject/view/screen/Onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen ({Key? key}) : super(key: key);

  @override
  State<SplashScreen > createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 150,
            ),
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.black,blurRadius: 10,spreadRadius: 10,blurStyle: BlurStyle.outer),
                      BoxShadow(color: Colors.black45,blurRadius: 10,spreadRadius: 10,blurStyle: BlurStyle.outer),
                    ],
                  ),
                  child: Text(
                    'Shop App',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        color: Color.fromRGBO(143, 148, 251, 1),
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                const Text(
                  'you find everything in here',
                  style: TextStyle(
                      fontFamily: "Pacifico",
                      color: Colors.black45,
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 200,
            ),
            const CircularProgressIndicator(color: Color.fromRGBO(143, 148, 251, 1),),
          ],
        ),
      ),
    );
  }

  void navigateHome() {
    Future.delayed(
      const Duration(seconds: 5),
          () => Get.off(OnBoarding(),transition: Transition.zoom,duration: const Duration(seconds: 1),curve: Curves.easeIn),
    );
  }
}
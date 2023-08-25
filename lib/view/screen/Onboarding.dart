import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Loginscreen.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController nextpage = PageController();

  int pagenumber = 0;

  Widget dotpageview() {
    return Builder(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 3; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              width: i == pagenumber ? 25 : 6,
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: i == pagenumber
                    ? Color.fromRGBO(255, 102, 178, 700)
                    : Colors.deepPurpleAccent,
              ),
            ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: PageView(
            controller: nextpage,
            onPageChanged: (value) {
              setState(() {
                pagenumber = value;
              });
            },
            children: [
              Column(
                children: [
                  Image.asset('assets/images/onboardingone.jpg'),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: const Text(
                        "Find the item you've been\n         looking for.",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 25,
                          fontFamily: "Pacifico",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Here you'll see rich varieties of goods,carefully \n   classified for seamless browsing experience.",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 15,
                      fontFamily: "Pacifico",
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          nextpage.animateToPage(1,
                              duration: Duration(milliseconds: 700),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          width: 114,
                          height: 54,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.deepPurple,
                                    Color.fromRGBO(255, 102, 178, 700)
                                  ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: "Pacifico",
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () {
                          nextpage.animateToPage(2,
                              duration: Duration(milliseconds: 700),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          width: 114,
                          height: 54,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.deepPurple,
                                    Color.fromRGBO(255, 102, 178, 700)
                                  ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Skip",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: "Pacifico",
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  dotpageview(),
                ],
              ),
              Column(
                children: [
                  Image.asset('assets/images/onboardingtwo.jpg'),
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: const Text(
                        "Add any item you want or \n              Save it.",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 25,
                          fontFamily: "Pacifico",
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "add any item you want to your cart,or save it on \n your wishlist,so you don't miss it in your future \n                             purchases.",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 15,
                      fontFamily: "Pacifico",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          nextpage.animateToPage(2,
                              duration: Duration(milliseconds: 700),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          width: 114,
                          height: 54,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.deepPurple,
                                    Color.fromRGBO(255, 102, 178, 700)
                                  ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: "Pacifico",
                            ),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      InkWell(
                        onTap: () {
                          nextpage.animateToPage(2,
                              duration: Duration(milliseconds: 700),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          width: 114,
                          height: 54,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.deepPurple,
                                    Color.fromRGBO(255, 102, 178, 700)
                                  ]),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "Skip",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: "Pacifico",
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  dotpageview(),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/onboardingthree.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.all(25),
                      padding: EdgeInsets.all(10),
                      child: const Text(
                        "Fast & Source payment",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 25,
                          fontFamily: "Pacifico",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "There ara many payment options available for \n                           your easy.",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 15,
                      fontFamily: "Pacifico",
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(loginscreen(),
                          transition: Transition.cupertino,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      width: 165,
                      height: 56,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.deepPurple,
                                Color.fromRGBO(255, 102, 178, 700)
                              ]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Pacifico",
                        ),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  dotpageview(),
                ],
              ),
            ],
          ),
        ));
  }
}

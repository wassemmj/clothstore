import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/view/screen/details_screen.dart';

import '../../core/constant/token.dart';

class Home1Screen extends StatefulWidget {
  const Home1Screen({Key? key}) : super(key: key);

  @override
  State<Home1Screen> createState() => _Home1ScreenState();
}

class _Home1ScreenState extends State<Home1Screen> {
  int currentIndex = 0;
  int selectedIndex = 0;
  List? sec = [];
  late Map<String, dynamic> li;

  List product = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: onPressed(),
      builder: (context, snapshot) {
        if (sec!.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(143, 148, 251, 1),
            ),
          );
        }
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    height: 200,
                    child: ListView.builder(
                      itemCount: 5,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: SizedBox(
                              width: 200,
                              child: Image.asset(
                                'assets/images/${index + 1}.jpg',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemCount: sec!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(143, 148, 251, 1)),
                                borderRadius: BorderRadius.circular(100),
                                color: index == currentIndex
                                    ? const Color.fromRGBO(143, 148, 251, 1)
                                    : Colors.transparent),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  currentIndex = index;
                                  selectedIndex = 0;
                                });
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                foregroundColor: MaterialStateProperty.all(
                                    index == currentIndex
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            143, 148, 251, 1)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(10)),
                              ),
                              child: Text(
                                sec![index],
                                style: const TextStyle(
                                  fontFamily: "Pacifico",
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemCount: li[sec![currentIndex]].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var ll = li[sec![currentIndex]];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(143, 148, 251, 1)),
                                borderRadius: BorderRadius.circular(100),
                                color: index == selectedIndex
                                    ? const Color.fromRGBO(143, 148, 251, 1)
                                    : Colors.transparent),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100))),
                                foregroundColor: MaterialStateProperty.all(
                                    index == selectedIndex
                                        ? Colors.white
                                        : const Color.fromRGBO(
                                            143, 148, 251, 1)),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(10)),
                              ),
                              child: Text(
                                ll[index]['name'],
                                style: const TextStyle(
                                  fontFamily: "Pacifico",
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Products',
                      style: TextStyle(
                        fontFamily: "Pacifico",
                        color: Color.fromRGBO(143, 148, 251, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: FutureBuilder(
                future: pro(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        width: 100,
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Color.fromRGBO(143, 148, 251, 1),
                        )));
                  }
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                       List li = product[index]['image'];
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                              DetailsScreen(
                                name: product[index]['name'],
                                desc: product[index]['description'],
                                price: product[index]['price'],
                                id: product[index]['id'],
                                discount : product[index]['discount'],
                                dura :  product[index]['discount_duration'],
                                colors : product[index]['colors'],
                                age : product[index]['age'],
                                gender : product[index]['gender'],
                                sizes : product[index]['sizes'],
                                brand : product[index]['brand'],
                                image: product[index]['image']
                              ),
                              transition: Transition.cupertino,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeIn);
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: const BorderSide(
                                        color: Color.fromRGBO(143, 148, 251, 1),
                                        width: 1)),
                                elevation: 0,
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 35),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              'http://192.168.43.184:8000/${li[0]}',
                                              fit: BoxFit.fill,
                                              width: 100,
                                              height: 100,
                                            ),
                                            // child: Image.asset(
                                            //   'assets/images/1.jpg',
                                            //   fit: BoxFit.fill,
                                            //     width: 100,
                                            //     height: 100,
                                            // ),
                                          ),
                                          const SizedBox(width: 15),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                product[index]['name'],
                                                style: const TextStyle(
                                                  fontFamily: "Pacifico",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      143, 148, 251, 1),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                width: 210,
                                                child: Text(
                                                  product[index]['description'],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: const TextStyle(
                                                    fontFamily: "Pacifico",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: const [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 25,
                                                  ),
                                                  Text(
                                                    '4.8',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Pacifico",
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Color.fromRGBO(143, 148, 251, 1),
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Future onPressed() async {
    var response = await http.get(
      Uri.parse('http://192.168.43.184:8000/api/getCategory'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> hg = jsonDecode(response.body);
      sec = hg.keys.toList();
      li = hg;
    } else {
      print(response.body);
    }
  }

  Future pro() async {
    var response = await http.get(
      Uri.parse('http://192.168.43.184:8000/api/showAllAdmin'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Token.token}'
      },
      // body: {
      //   'category_id': '${currentIndex + 1}',
      // },
    );
    if (response.statusCode == 200) {
      var hg = jsonDecode(response.body);
      print(hg[0]);
      // product = hg.where((element) => selectedIndex==element['brand_id']).toList();
      product = hg;
    } else {
      print(response.body);
    }
  }
}

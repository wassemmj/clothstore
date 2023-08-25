import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../core/constant/token.dart';
import 'details_screen.dart';

class ExpScreen extends StatefulWidget {
  const ExpScreen({Key? key}) : super(key: key);

  @override
  State<ExpScreen> createState() => _ExpScreenState();
}

class _ExpScreenState extends State<ExpScreen> {
  int indexList = 0;
  int selectedIndex = 0;
  List sec = [];
  List product = [];
  late Map<String,dynamic> li ;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: onPressed(),
      builder: (context, snapshot) {
        if(sec.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: Color.fromRGBO(143, 148, 251, 1) ,),);
        }
        return Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              itemCount: sec.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      indexList = index;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / sec.length,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(143, 148, 251, 1),
                      border: Border(
                          bottom: BorderSide(
                              color: indexList == index
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 3)),
                    ),
                    child: Text(
                      sec[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Pacifico",
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: li[sec[indexList]].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                var ll = li[sec[indexList]];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    width: li[sec[indexList]].length>5 ? 90:MediaQuery.of(context).size.width / li[sec[indexList]].length,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(143, 148, 251, 1),
                      border: Border(
                          bottom: BorderSide(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 3)),
                    ),
                    child: Text(
                      ll[index]['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Pacifico",
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
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
    var response = await http.get(Uri.parse('http://192.168.43.184:8000/api/getCategory'), headers: {
      'Accept': 'application/json'
    },);
    var response2 = await http.get(Uri.parse('http://192.168.43.184:8000/api/showAll'), headers: {
      'Accept': 'application/json'
    },);
    if(response.statusCode==200) {
      Map<String,dynamic> hg = jsonDecode(response.body);
      sec = hg.keys.toList();
      li = hg;
      print(li);
    } else {
      print(response.body);
    }
  }

  Future pro() async {
    var response = await http.get(
      Uri.parse('http://192.168.43.184:8000/api/showAllAdmin'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer ${Token.token}'
      },
    );
    if (response.statusCode == 200) {
      List hg = jsonDecode(response.body);
      product = hg;
    } else {
      print(response.body);
    }
  }
}
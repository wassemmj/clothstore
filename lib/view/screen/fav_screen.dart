import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myproject/core/constant/token.dart';
import 'details_screen.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List fav = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: onPressed(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(143, 148, 251, 1),
            ),
          );
        }
        return fav.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(15),
                child: ListView.builder(
                    itemCount: fav.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(DetailsScreen(
                            name: fav[index]['name'],
                            desc: fav[index]['description'],
                            price: fav[index]['price'],
                            id: fav[index]['id'],
                              discount : fav[index]['discount'],
                              dura :  fav[index]['discount_duration'],
                              colors : fav[index]['colors'],
                              age : fav[index]['age'],
                              gender : fav[index]['gender'],
                              sizes : fav[index]['sizes'],
                              brand : fav[index]['brand'],
                              image: fav[index]['image']
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
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        'assets/images/1.jpg',
                                        fit: BoxFit.fill,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          fav[index]['name'],
                                          style: const TextStyle(
                                            fontFamily: "Pacifico",
                                            fontSize: 20,
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
                                            fav[index]['description'],
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
                                                color: Colors.black45,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Color.fromRGBO(143, 148, 251, 1),
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      );
                    }),
              )
            : const Padding(
                padding: EdgeInsets.only(bottom: 200),
                child: Center(
                  child: Text(
                    'There is not any favorites products',
                    style: TextStyle(
                      fontFamily: "Pacifico",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
      },
    );
  }

  Future onPressed() async {
    var response = await http.get(
      Uri.parse('http://192.168.43.184:8000/api/favourites/get_fav_product'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Token.token}'
      },
    );
    if (response.statusCode == 200) {
      var hg = jsonDecode(response.body);
      fav = hg['products'];
      print(fav);
    } else {
      print(response.body);
    }
  }
}

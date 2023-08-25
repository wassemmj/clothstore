import 'dart:convert';

import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myproject/view/screen/Loginscreen.dart';
import 'package:myproject/view/screen/cart_screen.dart';
import 'package:myproject/view/screen/fav_screen.dart';
import 'package:myproject/view/screen/home1_screen.dart';
import 'package:http/http.dart' as http;
import '../../core/constant/token.dart';
import 'details_screen.dart';
import 'exp_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Map<String, Object>> _tabs;
  TextEditingController controller = TextEditingController();
  CircularBottomNavigationController? _navigationController;

  @override
  void initState() {
    _navigationController = CircularBottomNavigationController(_selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _tabs = [
      {
        'body': const Home1Screen(),
      },
      {
        'body': const FavScreen(),
      },
      {
        'body': const ExpScreen(),
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
        elevation: 0,
        title: const Text(
          'C.C',
          style: TextStyle(color: Colors.white, fontFamily: "Pacifico"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(const CartScreen(),
                    transition: Transition.leftToRightWithFade,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeIn);
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: MySearchDelegate());
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: _tabs[_selectedIndex]['body'] as Widget,
      ),
      bottomNavigationBar: CircularBottomNavigation(
        [
          TabItem(
            Icons.home_filled,
            'Home',
            const Color.fromRGBO(143, 148, 251, 1),
            labelStyle: const TextStyle(
              fontFamily: "Pacifico",
              fontWeight: FontWeight.normal,
            ),
          ),
          TabItem(
            Icons.favorite,
            "favorites",
            const Color.fromRGBO(143, 148, 251, 1),
            labelStyle: const TextStyle(
              fontFamily: "Pacifico",
              fontWeight: FontWeight.normal,
            ),
          ),
          TabItem(
            Icons.mood,
            "explore",
            const Color.fromRGBO(143, 148, 251, 1),
            labelStyle: const TextStyle(
              fontFamily: "Pacifico",
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
        controller: _navigationController,
        selectedPos: _selectedIndex,
        barBackgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        selectedCallback: (selected) {
          setState(() {
            _selectedIndex = selected!;
          });
        },
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                'enjoy your shopping',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontFamily: "Pacifico",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: InkWell(
                  onTap: () {
                    Get.to(loginscreen(),
                        transition: Transition.upToDown,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeIn);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18,
                          fontFamily: "Pacifico",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Icon(
                        Icons.logout,
                        size: 25,
                        color: Color.fromRGBO(143, 148, 251, 1),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResult = ['Sport shoes', 'nike', 'adidas'];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            })
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    return Result(
      query: query,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResult.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              showResults(context);
            },
          );
        });
  }
}

class Result extends StatefulWidget {
  const Result({Key? key, required this.query}) : super(key: key);

  final String query;

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List li = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: search(),
      builder: (context, snapshot) {
        List l = li.where((element) {
          List ll = element['name'].toString().toLowerCase().split('');
          // print(ll);
          List lll = widget.query.split('');
          // print(lll);
          for (int i = 0; i < lll.length; i++) {
            if (lll[i] != ll[i] || lll.length > ll.length) {
              return false;
            }
          }
          return true;
        }).toList();

        print('${l.length}');
        return snapshot.connectionState == ConnectionState.waiting
            ? (const Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(143, 148, 251, 1),
                ),
              ))
            : l.isNotEmpty
                ? ListView.builder(
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Get.to(DetailsScreen(
                          //   name: l[index]['name'],
                          //   desc: l[index]['description'],
                          //   price: l[index]['price'],
                          //   id: l[index]['id'],
                          //     discount : l[index]['discount'],
                          //     dura :  l[index]['discount_duration'],
                          //     colors : l[index]['colors'],
                          //     age : l[index]['age'],
                          //     gender : l[index]['gender'],
                          //     sizes : l[index]['sizes'],
                          //     brand : l[index]['brand'],
                          //     image: l[index]['image']
                          // ),
                          //     transition: Transition.cupertino,
                          //     duration: const Duration(seconds: 1),
                          //     curve: Curves.easeIn);
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
                                          l[index]['name'],
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
                                            l[index]['description'],
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
                    },
                  )
                : const Center(
                    child: Text(
                      "Not found",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  );
      },
    );
  }

  Future search() async {
    var response = await http.post(
      Uri.parse('http://192.168.43.184:8000/api/products/search'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer ${Token.token}'
      },
    );
    if (response.statusCode == 200) {
      var hg = jsonDecode(response.body);
      li = hg;
      print(li);
    } else {
      print(response.body);
    }
  }


}

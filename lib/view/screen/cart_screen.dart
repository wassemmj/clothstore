import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:myproject/core/constant/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List cat = [];
  int number = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await pro();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
        title: const Text(
          'Your Cart',
        ),
      ),
      body: FutureBuilder(
          future: pro(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: const [
                  SizedBox(
                    height: 250,
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(143, 148, 251, 1),
                    ),
                  )
                ],
              );
            }
            print(Cart.cart.length);
            return Column(children: [
              Expanded(
                flex: 14,
                child: Cart.cart.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(15),
                        child: ListView.builder(
                            itemCount: Cart.cart.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Cart.cart.remove(Cart.cart[index]);
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            side: const BorderSide(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 1),
                                                width: 1)),
                                        elevation: 0,
                                        color: Colors.white70,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  Cart.cart[index]['name'],
                                                  style: TextStyle(
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
                                                Text(
                                                  Cart.cart[index]['brand'],
                                                  style: TextStyle(
                                                    fontFamily: "Pacifico",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${Cart.cart[index]['quantity']}   /  ${Cart.cart[index]['total_price']}  \$',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black45,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                            'buy a product to add here',
                            style: TextStyle(
                              fontFamily: "Pacifico",
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
              ),
              Expanded(
                  child: InkWell(
                    onTap: () {
                      Cart.cart.clear();
                    },
                    child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                width: 450,
                decoration: BoxDecoration(
                      color: const Color.fromRGBO(143, 148, 251, 1),
                      borderRadius: BorderRadius.circular(20)),
                child: const Text(
                    'Buy all',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Pacifico",
                    ),
                ),
              ),
                  )),
            ]);
          }),
    );
  }

  Future pro() async {
    var response = await http.get(
      Uri.parse('http://192.168.43.184:8000/api/viewCart'),

    );
    if (response.statusCode == 200) {
      print(response.body);
      // print(response.body);
    } else {
      print(response.body);
    }
  }
}

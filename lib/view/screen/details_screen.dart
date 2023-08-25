import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myproject/core/constant/cart.dart';
import 'package:myproject/view/screen/comments.dart';

import '../../core/constant/token.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {Key? key,
      required this.name,
      required this.desc,
      required this.price,
      required this.id,
      required this.discount,
      required this.dura,
      required this.colors,
      required this.age,
      required this.gender,
      required this.sizes,
      required this.brand,
      required this.image})
      : super(key: key);

  final int id;
  final String name;
  final String desc;
  final int price;
  final int? discount;
  final String? dura;

  final List colors;

  final String age;

  final String gender;

  final List sizes;
  final String brand;
  final List image;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  double rate = 0;
  bool isFav = false;

  List fav = [];

  int number = 0;

  @override
  void initState() {
    super.initState();
    ge();
  }

  var rr;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await onPressed1();
    // fav =  Provider.of<ApiProvider>(context, listen: false).isMealFavorites(id);
    if (isFav) {
      onPressed1();
      setState(() {
        isFav = true;
      });
    } else {
      setState(() {
        isFav = false;
      });
      delFav();
    }
  }

  ge() async {
    await onPressed1();
    isFav = isMealFavorites(widget.id);
  }

  bool isMealFavorites(int id) {
    return fav.any((expert) {
      print(id);
      print(expert['id']);
      return id == expert['id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(100)),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            'http://192.168.43.184:8000/${widget.image[0]}'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Color.fromRGBO(143, 148, 251, 1),
                            size: 30,
                          ),
                        ),
                        IconButton(
                          onPressed: onPressed,
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.red,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.name + '  /  ' + widget.brand,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(143, 148, 251, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: "Pacifico",
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Pacifico",
                ),
              ),
              const SizedBox(height: 10),
              Text(
                ' ${widget.age} / ${widget.gender}  sizes available  ${widget.sizes}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Pacifico",
                ),
              ),
              const SizedBox(height: 10),
              widget.discount == null
                  ? Text(
                      ' discount  ${widget.discount} \$ ..... ${widget.dura}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Pacifico",
                      ),
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(int.parse(widget.colors[0].substring(1, 7),
                                radix: 16) +
                            0xFF000000),
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  widget.colors.length > 1
                      ? SizedBox(
                          height: 50,
                          width: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(int.parse(
                                      widget.colors[1].substring(1, 7),
                                      radix: 16) +
                                  0xFF000000),
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  Get.to(Comments(id: widget.id));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: const [
                      Text(
                        'Add Comment',
                        style: TextStyle(
                          fontFamily: "Pacifico",
                          color: Color.fromRGBO(143, 148, 251, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Icon(
                        Icons.comment,
                        color: Color.fromRGBO(143, 148, 251, 1),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Price :'.toUpperCase(),
                        style: const TextStyle(
                          color: Color.fromRGBO(143, 148, 251, 1),
                          fontSize: 20,
                          fontFamily: "Pacifico",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${widget.price} \$',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Pacifico",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'rate :'.toUpperCase(),
                        style: const TextStyle(
                          fontFamily: "Pacifico",
                          color: Color.fromRGBO(143, 148, 251, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Row(
                        children:  [
                          Icon(
                            Icons.star,
                            size: 25,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 5),
                          FutureBuilder(
                            future: getRate(),
                            builder: (context, snapshot) {
                              return Text(
                                rr.toString(),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Pacifico",
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'quantity',
                    style: TextStyle(
                      color: Color.fromRGBO(143, 148, 251, 1),
                      fontSize: 18,
                      fontFamily: "Pacifico",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (number <= 0) {
                              number = 0;
                            } else {
                              number--;
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Color.fromRGBO(143, 148, 251, 1),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$number',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: "Pacifico",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            number++;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Color.fromRGBO(143, 148, 251, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {
                          dialog(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(143, 148, 251, 1)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10)),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Pacifico",
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.shopping_cart,
                          size: 20,
                          color: Color.fromRGBO(143, 148, 251, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dialog(context) async {
    var response = await http.post(
      Uri.parse('http://192.168.43.184:8000/api/addToCart'),
      headers: {
        'Accept': 'application/json',
      },
      body: {'product_properties_id': '${widget.id}', 'quantity': '$number'},
    );
    if (response.statusCode == 200) {
      Map hg = jsonDecode(response.body);
      var g = hg.values.toList();
      var gg = g[0];
      Cart.cart.add({
        "quantity": '${gg[0]["quantity"]}',
        "total_price": '${gg[0]["total_price"]}',
        'name': widget.name,
        'brand': widget.brand,
        'id': widget.id,
        'desc': widget.desc,
       'image': 'http://192.168.43.184:8000/${widget.image[0]}',
      });
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Rate This product',
              style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
            ),
            content: RatingBar(
              minRating: 0,
              maxRating: 5,
              initialRating: 0,
              allowHalfRating: true,
              ratingWidget: RatingWidget(
                full: const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                half: const Icon(
                  Icons.star_half,
                  color: Colors.yellow,
                ),
                empty: const Icon(
                  Icons.star_border,
                ),
              ),
              onRatingUpdate: (double value) => rate = value,
              itemCount: 5,
              itemSize: 40,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              glow: false,
              updateOnDrag: true,
            ),
            actions: [
              TextButton(
                child: const Text(
                  'Done',
                  style: TextStyle(
                      color: Color.fromRGBO(143, 148, 251, 1), fontSize: 20),
                ),
                onPressed: () async {
                  var response = await http
                      .post(Uri.parse('http://192.168.43.184:8000/api/rate/create_rate'), headers: {
                    'Accept': 'application/json',
                    'Authorization': 'Bearer ${Token.token}'
                  }, body: {
                    'product_id': '${widget.id}',
                    'stars': '$rate',
                  });
                  print(response.body);
                  if (response.statusCode == 200) {
                    print(response.body);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        "Thanks for rating",
                        style: TextStyle(fontSize: 15),
                      ),
                      duration: Duration(seconds: 1),
                    ));
                    Navigator.of(ctx).pop();
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  //Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Color.fromRGBO(143, 148, 251, 1), fontSize: 20),
                ),
              ),
            ],
          );
        },
      );
      print(hg);
    } else {
      print(response.body);
    }
  }

  onPressed() async {
    if (isFav) {
      delFav();
    } else {
      add();
    }
    setState(() {
      isFav = !isFav;
    });
  }

  add() async {
    var response = await http.post(
      Uri.parse('http://192.168.43.184:8000/api/favourites/add_fav_product'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Token.token}'
      },
      body: {
        'product_id': '${widget.id}',
      },
    );
    if (response.statusCode == 200) {
      var hg = jsonDecode(response.body);
      print(hg);
    } else {
      print(response.body);
    }
  }

  Future onPressed1() async {
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
    } else {
      print(response.body);
    }
  }

  Future getRate() async {
    var response = await http.post(
      Uri.parse('http://192.168.43.184:8000/api/rate/get_final_rate'),
      headers: {
        'Accept': 'application/json',
        // 'Authorization': 'Bearer ${Token.token}'
      },
      body: {
        'product_id': '${widget.id}',
      },
    );
    if (response.statusCode == 200) {
      rr = response.body;
      print(rr);
    } else {
      print(response.body);
    }
  }

  delFav() async {
    var response = await http.delete(
      Uri.parse('http://192.168.43.184:8000/api/favourites/remove_fav_product'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Token.token}'
      },
      body: {
        'product_id': '${widget.id}',
      },
    );
    if (response.statusCode == 200) {
      var hg = jsonDecode(response.body);
      print(hg);
    } else {
      print(response.body);
    }
  }
}

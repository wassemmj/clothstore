import 'dart:convert';

import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../core/constant/token.dart';

class Comments extends StatefulWidget {
  const Comments({super.key, required this.id});

  @override
  _TestMeState createState() => _TestMeState();

  final int id;
}

class _TestMeState extends State<Comments> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List f = [];
  var ff;

  Future onPressed() async {
    var response = await http.post(
        Uri.parse('http://192.168.43.184:8000/api/comment/show_comments'),
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer ${Token.token}'
        },
        body: {
          'product_id': '${widget.id}',
        });
    if (response.statusCode == 200) {
      var hg = jsonDecode(response.body);
      f = hg['comment'];
      print(f);
    } else {
      print(response.body);
    }
  }

  Future num() async {
    var response = await http.post(
        Uri.parse('http://192.168.43.184:8000/api/comment/number_of_comments'),
        headers: {
          'Accept': 'application/json',
          // 'Authorization': 'Bearer ${Token.token}'
        },
        body: {
          'product_id': '${widget.id}',
        });
    if (response.statusCode == 200) {
      var hg = jsonDecode(response.body);
      ff = hg['Comments Number'];
      print(ff);
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Comment Page")),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          FutureBuilder(
            future: num(),
            builder: (context, snapshot) {
              return Text(
                '$ff',
                style: const TextStyle(
                  fontFamily: "Pacifico",
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              );
            },
          ),
          const SizedBox(width: 10,),
        ],
      ),
      body: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath: "https://picsum.photos/300/30"),
          labelText: 'Write a comment...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () async {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              var response = await http.post(
                  Uri.parse(
                      'http://192.168.43.184:8000/api/comment/add_comment'),
                  headers: {
                    'Accept': 'application/json',
                    'Authorization': 'Bearer ${Token.token}'
                  },
                  body: {
                    'product_id': '${widget.id}',
                    'comments': commentController.text,
                  });
              print(response.body);
              if (response.statusCode == 200) {
                var hg = jsonDecode(response.body);
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('done')));
                await onPressed();
              } else {
                var hg = jsonDecode(response.body);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(hg['message'])));
                formKey.currentState!.reset();
                print(response.body);
              }
              FocusScope.of(context).unfocus();
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white,
          sendWidget:
              const Icon(Icons.send_sharp, size: 30, color: Colors.white),
          child: FutureBuilder(
              future: onPressed(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(143, 148, 251, 1),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: f.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: del,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        title: const Text(
                          'User',
                          style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Pacifico",),
                        ),
                        trailing: Text(
                            f[i]['created_at'].toString().substring(0, 10)),
                        subtitle: Text(f[i]['comments'].toString(),
                            style: const TextStyle(fontSize: 15)),
                      ),
                    );
                  },
                );
              })),
    );
  }

  del() async {
    var response = await http.delete(
      Uri.parse('http://192.168.43.184:8000/api/comment/remove_comment'),
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
      await onPressed();
    } else {
      print(response.body);
    }
  }
}

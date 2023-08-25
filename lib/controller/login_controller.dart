import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var token = '';

  Future login(String email, String password) async {
    try {
      var response = await http.post(Uri.parse('http://192.168.1.103:8000/api/login'), headers: {
        'Accept': 'application/json'
      }, body: {
        'email': email,
        'password': password,
      });
      if(response.statusCode==200) {
        print(jsonDecode(response.body)['user']);
        token = jsonDecode(response.body)['token'];

      }
    } catch (e) {
      throw Exception();
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';

Future<User> createUser(
    String name, String email, String password, String role) async {
  // final responseGet =
  //     await http.get(Uri.parse('https://service.uomart.net/api/User/'));
  // var total = 0;
  // if (responseGet.statusCode == 200) {
  //   var user = User.fromListJson(jsonDecode(responseGet.body));
  //   total = user.length;
  final response = await http.post(
    Uri.parse(
      'https://service.uomart.net/api/User/',
    ),
    // Uri.parse(
    //   'https://localhost:7067/api/User',
    // ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email': email,
      'password': password,
      'role': role
    }),
  );

  if (response.statusCode == 201) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create user. Please try later');
  }
  // } else {
  //   throw Exception('Failed to create user');
  // }
}

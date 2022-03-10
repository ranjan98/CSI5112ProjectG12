import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user.dart';

Future<User> fetchUser(String email) async {
  final response = await http
      .get(Uri.parse('https://localhost:7067/api/user/User/ranjan@uottawa.ca'));

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get user data');
  }
}
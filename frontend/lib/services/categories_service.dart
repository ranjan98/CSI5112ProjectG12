import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';

Future<List<Category>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://localhost:7067/api/Cat/'));

  if (response.statusCode == 200) {
    // process the categories received in the response body
    return Category.fromListJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get user data');
  }
}

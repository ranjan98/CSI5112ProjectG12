import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/category.dart';

Future<List<Category>> fetchCategories() async {
  final response =
      await http.get(Uri.parse('https://service.uomart.net/api/Cat/'));

  if (response.statusCode == 200) {
    // process the categories received in the response body
    return Category.fromListJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get user data');
  }
}

Future<Category> addCategory(String name, String imageUrl) async {
  // final responseGet =
  //     await http.get(Uri.parse('https://service.uomart.net/api/Cat/'));
  // var total = 0;
  // if (responseGet.statusCode == 200) {
  //   var categories = Category.fromListJson(jsonDecode(responseGet.body));
  //   total = categories.length;
  final response = await http.post(
    Uri.parse(
      'https://service.uomart.net/api/Cat/',
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'cName': name, 'imgUrl': imageUrl}),
  );

  if (response.statusCode == 201) {
    return Category.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create product. Please try later');
  }
  // } else {
  //   throw Exception('Failed to create product');
  // }
}

Future<Category> editCategory(String cid, String name, String imageUrl) async {
  final response = await http.put(
    Uri.parse(
      'https://service.uomart.net/api/Cat/' + cid,
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'cid': cid, 'cName': name, 'imgUrl': imageUrl}),
  );
  if (response.statusCode == 204) {
    return Category.fromJson(
        <String, String>{'cid': cid, 'cName': name, 'imgUrl': imageUrl});
  } else {
    throw Exception('Failed to create product. Please try later');
  }
}

Future<Category> deleteCategory(Category category) async {
  final response = await http.delete(Uri.parse(
    'https://service.uomart.net/api/Cat/' + category.cid,
  ));
  if (response.statusCode == 204) {
    return category;
  } else {
    throw Exception('Failed to delete category. Please try later');
  }
}

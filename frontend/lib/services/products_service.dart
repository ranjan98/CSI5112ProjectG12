import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

Future<List<Product>> fetchProducts() async {
  final response =
      await http.get(Uri.parse('https://localhost:7067/api/prod/Prod/'));
  print(response.body);
  if (response.statusCode == 200) {
    // process the categories received in the response body
    return Product.fromListJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get user data');
  }
}

Future<List<Product>> fetchProductsForOneCategory(String category) async {
  final response =
      await http.get(Uri.parse('https://localhost:7067/api/prod/Prod/'));
  print(response.body);
  if (response.statusCode == 200) {
    // process the categories received in the response body
    return Product.fromListJsonOneCategory(jsonDecode(response.body), category);
  } else {
    throw Exception('Failed to get user data');
  }
}

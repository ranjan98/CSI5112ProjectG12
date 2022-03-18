import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

Future<List<Product>> fetchProducts() async {
  final response =
      await http.get(Uri.parse('https://localhost:7067/api/Prod/'));
  // print(response.body);
  if (response.statusCode == 200) {
    // process the categories received in the response body
    return Product.fromListJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get user data');
  }
}

Future<List<Product>> fetchProductsForOneCategory(String category) async {
  final response =
      await http.get(Uri.parse('https://localhost:7067/api/Prod/'));
  // print(response.body);
  if (response.statusCode == 200) {
    // process the categories received in the response body
    return Product.fromListJsonOneCategory(jsonDecode(response.body), category);
  } else {
    throw Exception('Failed to get user data');
  }
}

Future<Product> addProduct(String name, String merchantid, String category,
    String description, String price, String imageUrl) async {
  final responseGet =
      await http.get(Uri.parse('https://localhost:7067/api/Prod/'));
  var total = 0;
  if (responseGet.statusCode == 200) {
    var products = Product.fromListJson(jsonDecode(responseGet.body));
    total = products.length;
    final response = await http.post(
      Uri.parse(
        'https://localhost:7067/api/Prod/',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': "p" + (total + 1).toString(),
        'name': name,
        'merchantid': merchantid,
        'category': category,
        'description': description,
        'price': price,
        'imageurl': imageUrl
      }),
    );

    if (response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create product. Please try later');
    }
  } else {
    throw Exception('Failed to create product');
  }
}

Future<Product> editProduct(String id, String name, String merchantid,
    String category, String description, String price, String imageUrl) async {
  final response = await http.put(
    Uri.parse(
      'https://localhost:7067/api/Prod/' + id,
    ),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': "p" + id.toString(),
      'name': name,
      'merchantid': merchantid,
      'category': category,
      'description': description,
      'price': price,
      'imageurl': imageUrl
    }),
  );
  if (response.statusCode == 204) {
    return Product.fromJson(<String, String>{
      'id': "p" + id.toString(),
      'name': name,
      'merchantid': merchantid,
      'category': category,
      'description': description,
      'price': price,
      'imageurl': imageUrl
    });
  } else {
    throw Exception('Failed to modify product. Please try later');
  }
}

Future<Product> deleteProduct(Product product) async {
  final response = await http.delete(Uri.parse(
    'https://localhost:7067/api/Prod/' + product.id,
  ));
  if (response.statusCode == 204) {
    return product;
  } else {
    throw Exception('Failed to delete product. Please try later');
  }
}

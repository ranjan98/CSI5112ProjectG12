import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order.dart';
import '../providers/cart.dart';

Future<Order> createOrder(String invoiceNumber, String userid, double amount,
    List<CartItem> items, String datetime) async {
  final responseGet =
      await http.get(Uri.parse('https://localhost:7067/api/Orders/'));
  var total = 0;
  if (responseGet.statusCode == 200) {
    var order = Order.fromListJson(jsonDecode(responseGet.body));
    total = order.length;
    // we need to separately make products list in the form of json to send it to backend
    var products = [];
    for (var element in items) {
      products.add({
        'id': element.id,
        'price': element.price,
        'quantity': element.quantity,
        'title': element.title
      });
    }
    // post the data to backend - send http post request
    final response = await http.post(
      Uri.parse(
        'https://localhost:7067/api/Orders/',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': (total + 1).toString(),
        'invoicenumber': invoiceNumber,
        'userid': userid,
        'amount': amount,
        'items': products,
        'datetime': datetime
      }),
    );

    if (response.statusCode == 201) {
      return Order.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit the order. Please try later');
    }
  } else {
    throw Exception('Failed to submit the order');
  }
}

Future<List<Order>> fetchOrders() async {
  final response =
      await http.get(Uri.parse('https://service.uomart.net/api/Orders/'));

  if (response.statusCode == 200) {
    return Order.fromListJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get orders data');
  }
}

Future<Order> fetchOrder(String id) async {
  final response =
      await http.get(Uri.parse('https://service.uomart.net/api/Orders/' + id));

  if (response.statusCode == 200) {
    return Order.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to get order data');
  }
}

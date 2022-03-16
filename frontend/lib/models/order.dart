import '../providers/cart.dart';
// import 'cart.dart';

class Order {
  final String id;
  final String invoiceNumber;
  final String userId;
  final double amount;
  final List<CartItem> items;
  final String datetime;

  const Order(
      {required this.id,
      required this.invoiceNumber,
      required this.userId,
      required this.amount,
      required this.items,
      required this.datetime});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        invoiceNumber: json['invoicenumber'],
        userId: json['userid'],
        amount: json['amount'],
        items: CartItem.fromListJson(json['items']),
        datetime: json['datetime']);
  }
  static List<Order> fromListJson(List<dynamic> json) {
    List<Order> result = <Order>[];
    for (Map<String, dynamic> d in json) {
      result.add(Order.fromJson(d));
    }
    return result;
  }
}

// class CartItem {
//   final String id;
//   final double price;
//   final int quantity;
//   final String title;

//   const CartItem(
//       {required this.id,
//       required this.price,
//       required this.quantity,
//       required this.title});

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//         id: json['id'],
//         price: json['price'],
//         quantity: json['quantity'],
//         title: json['title']);
//   }
//   static List<CartItem> fromListJson(List<dynamic> json) {
//     List<CartItem> result = <CartItem>[];
//     for (Map<String, dynamic> d in json) {
//       result.add(CartItem.fromJson(d));
//     }
//     return result;
//   }
// }

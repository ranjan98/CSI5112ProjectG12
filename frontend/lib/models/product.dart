class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final String price;
  final String merchantid;
  final String imageUrl;

  const Product(
      {required this.id,
      required this.name,
      required this.category,
      required this.description,
      required this.price,
      required this.merchantid,
      required this.imageUrl});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        description: json['description'],
        price: json['price'],
        merchantid: json['merchantid'],
        imageUrl: json['imageurl']);
  }

  static List<Product> fromListJson(List<dynamic> json) {
    List<Product> result = <Product>[];
    for (Map<String, dynamic> d in json) {
      result.add(Product.fromJson(d));
    }
    return result;
  }

  // static List<Product> fromListJsonOneCategory(
  //     List<dynamic> json, String category) {
  //   List<Product> result = <Product>[];
  //   for (Map<String, dynamic> d in json) {
  //     if (Product.fromJson(d).category == category) {
  //       result.add(Product.fromJson(d));
  //     }
  //   }
  //   return result;
  // }
}

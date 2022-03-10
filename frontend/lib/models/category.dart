class Category {
  final String cid;
  final String cName;
  final String imgUrl;

  const Category(
      {required this.cid, required this.cName, required this.imgUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        cid: json['cid'], cName: json['cName'], imgUrl: json['imgUrl']);
  }

  static List<Category> fromListJson(List<dynamic> json) {
    List<Category> result = <Category>[];
    for (Map<String, dynamic> d in json) {
      result.add(Category.fromJson(d));
    }
    return result;
  }
}

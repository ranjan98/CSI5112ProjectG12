class User {
  final String uid;
  final String name;
  final String email;
  final String password;
  final String role;

  const User(
      {required this.uid,
      required this.name,
      required this.email,
      required this.password,
      required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        uid: json['uid'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        role: json['role']);
  }
  static List<User> fromListJson(List<dynamic> json) {
    List<User> result = <User>[];
    for (Map<String, dynamic> d in json) {
      result.add(User.fromJson(d));
    }
    return result;
  }
}

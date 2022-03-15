import 'package:flutter/foundation.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];

  List<User> get users {
    return [..._users];
  }

  void loginUser(User user) {
    _users = [];
    _users.add(user);
    notifyListeners();
  }

  void signOut() {
    _users = [];
    notifyListeners();
  }
}

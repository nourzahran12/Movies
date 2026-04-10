import 'package:flutter/cupertino.dart';
import 'package:movies/model/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? currentUser;

  void updateCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }
}

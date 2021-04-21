import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  int id;
  String name;

  updateUserName(val) {
    name = val;
    notifyListeners();
  }
}
// lib/features/auth/login/login_controller.dart
import 'package:flutter/foundation.dart';

class LoginController extends ChangeNotifier {
  String email = '';
  String password = '';

  void updateEmail(String v) {
    email = v;
    notifyListeners();
  }

  void updatePassword(String v) {
    password = v;
    notifyListeners();
  }

  bool get canSubmit =>
    email.contains('@') &&
    password.length >= 6;
}

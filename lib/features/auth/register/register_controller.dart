// lib/features/auth/register/register_controller.dart
import 'package:flutter/foundation.dart';

class RegisterController extends ChangeNotifier {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  void updateName(String v) {
    name = v;
    notifyListeners();
  }

  void updateEmail(String v) {
    email = v;
    notifyListeners();
  }

  void updatePassword(String v) {
    password = v;
    notifyListeners();
  }

  void updateConfirmPassword(String v) {
    confirmPassword = v;
    notifyListeners();
  }

  bool get canSubmit =>
    name.isNotEmpty &&
    email.contains('@') &&
    password.length >= 6 &&
    password == confirmPassword;
}

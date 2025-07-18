import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  final AuthService authService;
  LoginController({ required this.authService });

  String email = '';
  String password = '';
  bool isLoading = false;

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
    password.length >= 6 &&
    !isLoading;

  Future<bool> login() async {
  isLoading = true;
  notifyListeners();

  try {
    final result = await authService.login(email: email, password: password);
    print('🟢 Resposta da api: ${result}');
    if (result != null) {
        print('🟢 Token recebido: ${result.token}');
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', result.token);
        return true;
    } else {
        print('🔴 Login falhou: resposta nula');
        return false;
    }
    } catch (e) {
        print('🔴 Erro: $e');
        return false;
    } finally {
        isLoading = false;
        notifyListeners();
    }
}
}
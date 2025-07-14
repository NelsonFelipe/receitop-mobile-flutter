// lib/features/auth/register/register_controller.dart
import 'package:flutter/foundation.dart';
import '../models/user_dto.dart';
import '../services/auth_service.dart';

class RegisterController extends ChangeNotifier {
  final AuthService authService;

  RegisterController({ required this.authService });

  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  bool isLoading = false;
  String? errorMessage;

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
    password == confirmPassword &&
    !isLoading;

  Future<void> submitRegistration() async {
    if (!canSubmit) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final user = UserDTO(
      name: name,
      email: email,
      password: password,
    );

    try {
      final success = await authService.register(user);
      if (!success) {
        errorMessage = 'Falha ao registrar. Tente novamente.';
      }
      // Se sucesso, faça aqui o que for necessário:
      // ex: navegação para outra tela ou limpeza de campos
    } catch (e) {
      errorMessage = 'Erro de conexão: ${e.toString()}';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

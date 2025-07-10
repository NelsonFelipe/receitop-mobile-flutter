// lib/features/profile/profile_controller.dart
import 'package:flutter/foundation.dart';

class ProfileController extends ChangeNotifier {
  String name = 'Nome do Usuário';
  String email = 'usuario@exemplo.com';
  int recipesCount = 12;
  int favoritesCount = 34;
  int followingCount = 8;

  // Em um caso real, você buscaria essas infos de uma API
  Future<void> loadProfile() async {
    // simula carregamento
    await Future.delayed(const Duration(milliseconds: 500));
    notifyListeners();
  }
}

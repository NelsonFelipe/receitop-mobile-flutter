// lib/features/profile/profile_controller.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  final String baseUrl = 'http://10.0.2.2:3333';

  String name = 'Nome do Usuário';
  String email = 'usuario@exemplo.com';
  int recipesCount = 0;
  int favoritesCount = 0;
  int followingCount = 0;

  bool isLoading = false;
  String? error;

  Future<void> loadProfile() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception('Token de autenticação não encontrado.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/profile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        name = data['user']['name'];
        email = data['user']['email'];

        final favoritesResponse = await http.get(
          Uri.parse('$baseUrl/favorite-recipe'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (favoritesResponse.statusCode == 200) {
          final List<dynamic> favoritesData = jsonDecode(favoritesResponse.body);
          favoritesCount = favoritesData.length;
        } else {
          print('Falha ao carregar contagem de favoritos: ${favoritesResponse.statusCode}');
        }
      } else {
        throw Exception('Falha ao carregar perfil: ${response.statusCode}');
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

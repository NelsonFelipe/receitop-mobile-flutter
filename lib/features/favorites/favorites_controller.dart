import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../recipes/details/recipe_details_model.dart';

class FavoritesController extends ChangeNotifier {
  final String baseUrl = 'http://10.0.2.2:3333';

  List<RecipeDetails> _favorites = [];
  List<RecipeDetails> _filteredFavorites = [];

  List<RecipeDetails> get favorites => List.unmodifiable(_filteredFavorites);

  bool isLoading = false;
  String? error;

  Future<void> loadFavorites() async {
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
        Uri.parse('$baseUrl/favorite-recipe'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _favorites = data.map((json) => RecipeDetails.fromJson(json)).toList();
        _filteredFavorites = List.from(_favorites); // Initialize filtered favorites
      } else {
        throw Exception('Falha ao carregar receitas favoritas: ${response.statusCode}');
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterFavorites(String query) {
    if (query.isEmpty) {
      _filteredFavorites = List.from(_favorites);
    } else {
      _filteredFavorites = _favorites
          .where((favorite) =>
              favorite.name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<void> removeFavorite(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      error = 'Token de autenticação não encontrado.';
      notifyListeners();
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/recipe/$recipeId/favorite'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        _favorites.removeWhere((fav) => fav.id == recipeId);
      } else {
        error = 'Falha ao remover favorito: ${response.statusCode}';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
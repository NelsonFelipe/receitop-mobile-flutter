import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'recipe_details_model.dart';

class RecipeDetailsController extends ChangeNotifier {
  final String baseUrl = 'http://10.0.2.2:3333';
  RecipeDetails? recipe;
  bool isLoading = false;
  String? error;
  bool _isFavorited = false;

  bool get isFavorited => _isFavorited;

  Future<void> fetchRecipeDetails(String recipeId) async {
    await checkFavoriteStatus(recipeId);
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
        Uri.parse('$baseUrl/recipe/$recipeId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        recipe = RecipeDetails.fromJson(data);
      } else {
        throw Exception('Falha ao carregar os detalhes da receita.');
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkFavoriteStatus(String recipeId) async {
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
        final List<dynamic> favoriteRecipes = jsonDecode(response.body);
        _isFavorited = favoriteRecipes.any((recipe) => recipe['id'] == recipeId);
      } else {
        _isFavorited = false;
      }
    } catch (e) {
      _isFavorited = false;
      print('Erro ao verificar status de favorito: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> toggleFavorite(String recipeId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) {
      error = 'Token de autenticação não encontrado.';
      notifyListeners();
      return;
    }

    try {
      http.Response response;
      if (_isFavorited) {
        response = await http.delete(
          Uri.parse('$baseUrl/recipe/$recipeId/unfavorite'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
      } else {
        response = await http.post(
          Uri.parse('$baseUrl/recipe/$recipeId/favorite'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
      }

      if (response.statusCode == 200 || response.statusCode == 204) {
        _isFavorited = !_isFavorited;
        if (!_isFavorited) {
          Fluttertoast.showToast(
            msg: "Receita removida dos favoritos!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        error = 'Falha ao alternar favorito.';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }
}

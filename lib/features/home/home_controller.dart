// lib/features/home/home_controller.dart

import 'package:flutter/foundation.dart';
import '../recipes/models/recipe.dart';
import '../recipes/recipe_repository.dart';

class HomeController extends ChangeNotifier {
  final RecipeRepository _repository;

  HomeController({required RecipeRepository repository}) : _repository = repository;

  List<Recipe> _recipes = [];
  List<Recipe> _filteredRecipes = [];

  List<Recipe> get recipes => List.unmodifiable(_filteredRecipes);

  bool isLoading = false;
  String? error;

  Future<void> loadRecipes() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0MWZjMzY0Yi1jYzliLTRmZjEtYmRiYy02NzRmYjJmYzI5MzUiLCJpYXQiOjE3NTI3NzQ1NDMsImV4cCI6MTc1MzM3OTM0M30.wqDD-S4Ek312uSXZOxQw_8OvK9kOOQhANYN83fuF1iY"; 
      _recipes = await _repository.getRecipes(token: token);
      _filteredRecipes = List.from(_recipes); // Initialize filtered recipes
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filterRecipes(String query) {
    if (query.isEmpty) {
      _filteredRecipes = List.from(_recipes);
    } else {
      _filteredRecipes = _recipes
          .where((recipe) =>
              recipe.name.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

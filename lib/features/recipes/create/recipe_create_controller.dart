import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import '../recipe_repository.dart';

class RecipeCreateController extends ChangeNotifier {
  final RecipeRepository _recipeRepository;

  RecipeCreateController({required RecipeRepository recipeRepository})
      : _recipeRepository = recipeRepository;

  String name = '';
  File? imageFile;
  String description = '';
  List<String> ingredients = [];
  List<String> steps = [];
  bool isLoading = false;
  
  void updateName(String v) { name = v; notifyListeners(); }
  void updateDescription(String v) { description = v; notifyListeners(); }

  void pickImage(File f) {
    imageFile = f; notifyListeners();
  }

  void addIngredient() {
    ingredients.add(''); notifyListeners();
  }

  void removeIngredient(int i) {
    ingredients.removeAt(i); notifyListeners();
  }

  void updateIngredient(int i, String v) {
    ingredients[i] = v; notifyListeners();
  }

  void addStep() {
    steps.add(''); notifyListeners();
  }

  void removeStep(int i) {
    steps.removeAt(i); notifyListeners();
  }

  void updateStep(int i, String v) {
    steps[i] = v; notifyListeners();
  }

  Future<void> saveRecipe() async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? authToken = prefs.getString('auth_token');

      if (authToken == null) {
        throw Exception('Auth token not found');
      }

      await _recipeRepository.createRecipe(
        name: name,
        description: description,
        imageFile: imageFile,
        ingredients: ingredients,
        steps: steps,
        token: authToken,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool get canSubmit =>
    !isLoading &&
    name.isNotEmpty &&
    imageFile != null &&
    description.isNotEmpty &&
    ingredients.isNotEmpty && ingredients.every((e) => e.isNotEmpty) &&
    steps.isNotEmpty && steps.every((s) => s.isNotEmpty);
}


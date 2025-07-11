// lib/features/recipes/create/recipe_create_controller.dart
import 'package:flutter/foundation.dart';
import 'dart:io';

class RecipeCreateController extends ChangeNotifier {
  String name = '';
  File? imageFile;
  String description = '';
  List<String> ingredients = [''];
  List<String> steps = [''];
  
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

  bool get canSubmit =>
    name.isNotEmpty &&
    imageFile != null &&
    description.isNotEmpty &&
    ingredients.every((e) => e.isNotEmpty) &&
    steps.every((s) => s.isNotEmpty);
}

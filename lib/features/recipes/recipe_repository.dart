
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'models/recipe.dart';

class RecipeRepository {
  final String baseUrl;

  RecipeRepository({required this.baseUrl});

  Future<List<Recipe>> getRecipes({required String token}) async {
    final url = Uri.parse('$baseUrl/recipe');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<void> createRecipe({
    required String name,
    required String description,
    required File? imageFile,
    required List<String> ingredients,
    required List<String> steps,
    required String token,
  }) async {
    final url = Uri.parse('$baseUrl/recipe');
    final request = http.MultipartRequest('POST', url);

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['ingredients'] = jsonEncode(ingredients);
    request.fields['steps'] = jsonEncode(steps);

    if (imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'imageUrl',
          imageFile.path,
        ),
      );
    }

    final response = await request.send();

    if (response.statusCode != 201) {
      throw Exception('Failed to create recipe');
    }
  }
}

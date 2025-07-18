
class RecipeDetails {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final List<String> ingredients;
  final List<String> steps;

  RecipeDetails({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.ingredients,
    required this.steps,
  });

  factory RecipeDetails.fromJson(Map<String, dynamic> json) {
    return RecipeDetails(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
    );
  }
}

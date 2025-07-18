class Recipe {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final DateTime createdAt;
  final DateTime updatedAt;

  Recipe({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

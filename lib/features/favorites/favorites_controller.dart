// lib/features/favorites/favorites_controller.dart
import 'package:flutter/foundation.dart';
import '../home/models/cat_image.dart';
import '../home/services/cat_service.dart';

class FavoritesController extends ChangeNotifier {
  final _service = CatService();

  // 1) Sua lista de títulos paralela
  final List<String> _titles = [
    'Pizza',
    'Saladas',
    'Bolo de Chocolate',
    'Sobremesas',
    'Bebidas',
    'Lanches',
    'Massas',
    'Vegetariano',
    'Vegano',
    'Doces'
  ];
  List<String> get titles => List.unmodifiable(_titles);

  // 2) Lista de imagens (objetos CatImage)
  List<CatImage> _favorites = [];
  List<CatImage> get favorites => List.unmodifiable(_favorites);

  bool isLoading = false;
  String? error;

  Future<void> loadFavorites() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      _favorites = await _service.fetchCats(limit: 14);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Remove uma imagem dos favoritos e atualiza a UI
  Future<void> removeFavorite(CatImage fav) async {
    // Remove usando igualdade de instância ou URL como identificador
    _favorites.removeWhere((f) => f.url == fav.url);
    notifyListeners();
  }
}

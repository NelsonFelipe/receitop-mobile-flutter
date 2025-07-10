// lib/features/home/home_controller.dart

import 'package:flutter/foundation.dart';
import 'models/cat_image.dart';
import 'services/cat_service.dart';

class HomeController extends ChangeNotifier {
  final _service = CatService();

  List<CatImage> _cats = [];
  List<CatImage> get cats => List.unmodifiable(_cats);

  bool isLoading = false;
  String? error;

  Future<void> loadCats() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      _cats = await _service.fetchCats(limit: 7);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Opcional: ainda expõe nomes de categorias (ou remova se for usar só cats)
  final List<String> _categories = [
    'Pizza',
    'Saladas',
    'Pratos Principais',
    'Sobremesas',
    'Bebidas',
    'Lanches',
    'Massas',
  ];
  List<String> get categories => List.unmodifiable(_categories);
}

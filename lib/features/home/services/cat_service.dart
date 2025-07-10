// lib/features/home/services/cat_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cat_image.dart';

class CatService {
  static const _apiKey = 'SUA_API_KEY_AQUI'; // <– substitua pela sua key

  Future<List<CatImage>> fetchCats({int limit = 7}) async {
    final uri = Uri.https(
      'api.thecatapi.com',
      '/v1/images/search',
      {
        'limit': '$limit',
        'size': 'med',
        'mime_types': 'jpg,png',
      },
    );

    final response = await http.get(
      uri,
      headers: {'x-api-key': _apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List;
      return data.map((json) => CatImage.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar imagens: ${response.statusCode}');
    }
  }
}

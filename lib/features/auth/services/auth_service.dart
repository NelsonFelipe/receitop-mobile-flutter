import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_dto.dart';

class AuthService {
  final String baseUrl;

  AuthService({ required this.baseUrl });

  /// Faz o registro de um novo usuário.
  /// Retorna true em caso de 201 Created, false em qualquer outro status.
  Future<bool> register(UserDTO user) async {
    final uri = Uri.parse('$baseUrl/users');
    final response = await http.post(
      uri,
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode(user.toJson()),
    );
    return response.statusCode == 201;
  }

  /// Faz login e retorna um UserDTO preenchido com o token (se sucesso),
  /// ou null em caso de falha.
  Future<UserDTO?> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$baseUrl/sessions');
    final response = await http.post(
      uri,
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return UserDTO.fromJson(data);
    }
    return null;
  }
}

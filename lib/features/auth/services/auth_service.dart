import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_dto.dart';

class AuthService {
  final String baseUrl;

  AuthService({ required this.baseUrl });

  Future<bool> register(UserDTO user) async {
    final uri = Uri.parse('$baseUrl/users');
    final response = await http.post(
      uri,
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode(user.toJson()),
    );
    return response.statusCode == 201;
  }

 Future<LoginResponse?> login({
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

  print('🔵 Status code: ${response.statusCode}');
print('🔵 Body: ${response.body}');

  if (response.statusCode == 201) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return LoginResponse.fromJson(data);
  }

  return null;
}
}

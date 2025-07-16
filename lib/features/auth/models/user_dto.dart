// lib/features/auth/models/user_dto.dart
class UserDTO {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String? token;  // para guardar JWT na resposta de login

  UserDTO({ this.id, required this.name, required this.email, required this.password, this.token });

  factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
    id: json['id'] as String?,
    name: json['name'],
    email: json['email'],
    password: '',           
    token: json['token'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
  };
}

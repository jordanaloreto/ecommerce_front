
import 'package:ecommerce_front/models/role.dart';

class User {
  int id;
  String userName;
  String password;
  int roleId; // ID da role à qual a subcategoria pertence
  Role role; // Objeto Role para acessar informações da role

  // Construtor da classe SubCategory
  User({
    required this.id,
    required this.userName,
    required this.password,
    required this.roleId,
    required this.role,
  });

  // Fábrica que cria uma instância de SubCategory a partir de um JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['user_name'],
      password: json['password'],
      roleId: json['role_id'],
      role: Role.fromJson(json['role']),
    );
  }

  // Método que converte uma instância de User para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'password': password,
      'role_id': roleId,
    };
  }
}
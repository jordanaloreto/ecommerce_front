import 'dart:convert';
import 'package:ecommerce_front/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'package:ecommerce_front/utils/app_storage.dart';
import '../screens/login_screen.dart';

class UserRepository {
  final String baseUrl =
      "http://localhost:8000"; // Troque pela URL do seu backend

  // Função para buscar todas as subcategorias de uma categoria específica

  Future<Map<String, String>> _getHeaders() async {
    final token = AppStorage.instance.token;
    if (token != null) {
      return {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
    }
    return {"Content-Type": "application/json"};
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'),
        headers: await _getHeaders());

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<User> users = body.map((item) => User.fromJson(item)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Função para criar uma nova subcategoria
  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/save'),
      headers: await _getHeaders(),
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create user');
    }
  }

  // Função para deletar uma subcategoria
  Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/user/$id'),
        headers: await _getHeaders());

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }

  Future<User> updateUser(int id, User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: await _getHeaders(),
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update user');
    }
  }

}

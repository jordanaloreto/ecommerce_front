import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/categoria.dart';
import 'package:ecommerce_front/utils/app_storage.dart';

import '../screens/login_screen.dart';

class CategoriaRepository {
  final String baseUrl =
      "http://localhost:8000"; // Troque pela URL do seu backend


  /// Método para obter os cabeçalhos de autenticação
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

  /// Método genérico para tratar o erro 401
  void _handleUnauthorized() {
    AppStorage.instance.removeToken(); // Remove o token inválido
    MyApp.navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  Future<List<Categoria>> fetchCategorias() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/categorias'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => Categoria.fromJson(item)).toList();
    } else if (response.statusCode == 401) {
      _handleUnauthorized(); // Trata o erro 401
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load categorias');
    }
  }

  Future<Categoria> createCategoria(Categoria categoria) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/categoria/save'),
      headers: headers,
      body: jsonEncode(categoria.toJson()),
    );

    if (response.statusCode == 200) {
      return Categoria.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      _handleUnauthorized(); // Trata o erro 401
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to create categoria');
    }
  }

  Future<void> deleteCategoria(int id) async {
    final headers = await _getHeaders();
    final response = await http.delete(
      Uri.parse('$baseUrl/categoria/$id'),
      headers: headers,
    );

  if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      _handleUnauthorized(); // Trata o erro 401
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to delete categoria');
    }
  }

  Future<Categoria> updateCategoria(Categoria categoria) async {
  final headers = await _getHeaders();
  final response = await http.put(
    Uri.parse('$baseUrl/categoria/${categoria.id}'),
    headers: headers,
    body: jsonEncode(categoria.toJson()),
  );

  if (response.statusCode == 200) {
    return Categoria.fromJson(jsonDecode(response.body));
  } else if (response.statusCode == 401) {
    _handleUnauthorized();
    throw Exception('Unauthorized');
  } else {
    throw Exception('Failed to update categoria');
  }
}

}
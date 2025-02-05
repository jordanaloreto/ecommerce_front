import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../models/sub_categoria.dart';
import 'package:ecommerce_front/utils/app_storage.dart';

import '../screens/login_screen.dart';

class SubCategoriaRepository {
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

  Future<List<SubCategoria>> fetchSubCategorias() async {
    final headers = await _getHeaders();
    final response = await http.get(
      Uri.parse('$baseUrl/subcategories'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((item) => SubCategoria.fromJson(item)).toList();
    } else if (response.statusCode == 401) {
      _handleUnauthorized(); // Trata o erro 401
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to load subCategorias');
    }
  }

  Future<SubCategoria> createSubCategoria(SubCategoria subCategoria) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl/subcategories/save'),
      headers: headers,
      body: jsonEncode(subCategoria.toJson()),
    );

    if (response.statusCode == 200) {
      return SubCategoria.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      _handleUnauthorized(); // Trata o erro 401
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to create subCategoria');
    }
  }

  Future<void> deleteSubCategoria(int id) async {
    final headers = await _getHeaders();
    final response = await http.delete(
      Uri.parse('$baseUrl/subcategories/$id'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      _handleUnauthorized(); // Trata o erro 401
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to delete subCategoria');
    }
  }

  Future<SubCategoria> updateSubCategoria(SubCategoria subCategoria) async {
    final headers = await _getHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl/subcategories/${subCategoria.id}'),
      headers: headers,
      body: jsonEncode(subCategoria.toJson()),
    );

    if (response.statusCode == 200) {
      return SubCategoria.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      _handleUnauthorized();
      throw Exception('Unauthorized');
    } else {
      throw Exception('Failed to update subCategoria');
    }
  }

}

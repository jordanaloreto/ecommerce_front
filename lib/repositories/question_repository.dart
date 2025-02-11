// lib/repositories/question_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class QuestionRepository {
  final String _baseUrl = 'http://sua-api.com'; // Substitua pela URL do seu backend

  Future<List<Question>> getQuestionsByProduct(int productId) async {
    final response = await http.get(Uri.parse('$_baseUrl/product/$productId/questions'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Question.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar perguntas');
    }
  }

  Future<Question> createQuestion(Question question) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/product/question'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(question.toJson()),
    );

    if (response.statusCode == 201) {
      return Question.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao criar pergunta');
    }
  }

  Future<Question> answerQuestion(int questionId, String answer) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/product/question/$questionId/answer'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'answer': answer, 'is_admin': true}), // Garantindo que apenas admins respondam
    );

    if (response.statusCode == 200) {
      return Question.fromJson(json.decode(response.body));
    } else if (response.statusCode == 403) {
      throw Exception('Apenas administradores podem responder perguntas.');
    } else if (response.statusCode == 404) {
      throw Exception('Pergunta não encontrada.');
    } else {
      throw Exception('Falha ao responder pergunta');
    }
  }
}
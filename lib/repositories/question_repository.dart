// lib/repositories/question_repository.dart
import 'dart:convert';
import 'package:ecommerce_front/utils/app_storage.dart';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class QuestionRepository {
  final String _baseUrl = 'http://localhost:8000'; // Substitua pela URL do seu backend
  
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

  Future<List<Question>> getQuestions() async {
    final response = await http.get(Uri.parse('$_baseUrl/questions'),headers: await _getHeaders(),
);

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Question.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar perguntas');
    }
  }
  Future<List<Question>> getQuestionsByProduct(int productId) async {
    final response = await http.get(Uri.parse('$_baseUrl/product/$productId/questions'),headers: await _getHeaders(),
);

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
      headers: await _getHeaders(),
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
    Uri.parse('$_baseUrl/product/question/$questionId/answer?answer=$answer&is_admin=true'), // Agora os dados vão na URL
    headers: await _getHeaders(),
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
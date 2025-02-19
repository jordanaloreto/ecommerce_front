// lib/controllers/question_controller.dart
import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/question_service.dart';

class QuestionController with ChangeNotifier {
  final QuestionService _service = QuestionService();
  List<Question> _questions = [];
  bool _isLoading = false;

  List<Question> get questions => _questions;
  bool get isLoading => _isLoading;

  Future<void> loadQuestions(int productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _questions = await _service.getQuestionsByProduct(productId);
    } catch (e) {
      print('Erro ao carregar perguntas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> loadAllQuestions() async {
    _isLoading = true;
    notifyListeners();

    try {
      _questions = await _service.getQuestions();
    } catch (e) {
      print('Erro ao carregar perguntas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addQuestion(Question question) async {
    try {
      final newQuestion = await _service.createQuestion(question);
      _questions.add(newQuestion);
      notifyListeners();
    } catch (e) {
      print('Erro ao adicionar pergunta: $e');
    }
  }

  Future<void> answerQuestion(int questionId, String answer) async {
    try {
      final updatedQuestion = await _service.answerQuestion(questionId, answer);
      final index = _questions.indexWhere((q) => q.id == questionId);
      if (index != -1) {
        _questions[index] = updatedQuestion;
        notifyListeners();
      }
    } catch (e) {
      print('Erro ao responder pergunta: $e');
    }
  }
}
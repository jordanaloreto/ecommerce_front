// lib/services/question_service.dart
import '../models/question.dart';
import '../repositories/question_repository.dart';

class QuestionService {
  final QuestionRepository _repository = QuestionRepository();

  Future<List<Question>> getQuestionsByProduct(int productId) async {
    return await _repository.getQuestionsByProduct(productId);
  }

  Future<Question> createQuestion(Question question) async {
    return await _repository.createQuestion(question);
  }

  Future<Question> answerQuestion(int questionId, String answer) async {
    return await _repository.answerQuestion(questionId, answer);
  }
}
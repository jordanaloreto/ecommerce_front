import 'package:ecommerce_front/models/question.dart';

class Question {
  final int id;
  final int productId;
  final int customerId;
  final String question;
  final String? answer;

  Question({
    required this.id,
    required this.productId,
    required this.customerId,
    required this.question,
    this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      productId: json['product_id'],
      customerId: json['customer_id'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'customer_id': customerId,
      'question': question,
      'answer': answer,
    };
  }
}
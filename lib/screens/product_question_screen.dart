// lib/screens/product_questions_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/question_controller.dart';

class ProductQuestionsScreen extends StatefulWidget {
  final int productId;

  ProductQuestionsScreen({required this.productId});

  @override
  _ProductQuestionsScreenState createState() => _ProductQuestionsScreenState();
}

class _ProductQuestionsScreenState extends State<ProductQuestionsScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega as perguntas ao iniciar a tela
    final controller = Provider.of<QuestionController>(context, listen: false);
    controller.loadQuestions(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuestionController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perguntas sobre o Produto'),
      ),
      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : controller.questions.isEmpty
              ? Center(child: Text('Nenhuma pergunta encontrada'))
              : ListView.builder(
                  itemCount: controller.questions.length,
                  itemBuilder: (context, index) {
                    final question = controller.questions[index];
                    return ListTile(
                      title: Text(question.question),
                      subtitle: question.answer != null
                          ? Text('Resposta: ${question.answer}')
                          : Text('Aguardando resposta...'),
                    );
                  },
                ),
    );
  }
}
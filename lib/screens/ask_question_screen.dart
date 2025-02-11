// screens/ask_question_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/question_controller.dart';
import '../models/question.dart';

class AskQuestionScreen extends StatefulWidget {
  final int productId;

  AskQuestionScreen({required this.productId});

  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuestionController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Fazer uma Pergunta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: 'Sua Pergunta',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final questionText = _questionController.text.trim();
                if (questionText.isNotEmpty) {
                  await controller.addQuestion(
                    Question(
                      id: 0, // O ID será gerado pelo backend
                      productId: widget.productId,
                      customerId: 8, // Substitua pelo ID do cliente logado
                      question: questionText,
                    ),
                  );
                  Navigator.pop(context); // Volta para a tela anterior
                }
              },
              child: Text('Enviar Pergunta'),
            ),
          ],
        ),
      ),
    );
  }
}
// lib/screens/admin_answer_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/question_controller.dart';
import '../models/question.dart';

class AdminAnswerScreen extends StatefulWidget {
  final Question question; // Adicione este parâmetro

  const AdminAnswerScreen({required this.question}); // Construtor atualizado

  @override
  _AdminAnswerScreenState createState() => _AdminAnswerScreenState();
}

class _AdminAnswerScreenState extends State<AdminAnswerScreen> {
  final TextEditingController _answerController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitAnswer() async {
    if (_answerController.text.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final controller = Provider.of<QuestionController>(context, listen: false);
      await controller.answerQuestion(widget.question.id, _answerController.text);
      Navigator.pop(context, true); // Retorna true para indicar sucesso
    } catch (e) {
      print('Erro ao responder pergunta: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Responder Pergunta")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pergunta: ${widget.question.question}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(
                hintText: "Digite a resposta...",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : _submitAnswer,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Enviar Resposta"),
            ),
          ],
        ),
      ),
    );
  }
}

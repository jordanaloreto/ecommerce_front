import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/question_controller.dart';
import 'admin_answer_screen.dart';

class AdminQuestionsListScreen extends StatefulWidget {
  @override
  _AdminQuestionsListScreenState createState() => _AdminQuestionsListScreenState();
}

class _AdminQuestionsListScreenState extends State<AdminQuestionsListScreen> {
  @override
  void initState() {
    super.initState();
    final controller = Provider.of<QuestionController>(context, listen: false);
    controller.loadAllQuestions(); // 0 ou outro valor para carregar todas as perguntas
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<QuestionController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Perguntas dos Clientes'),
      ),
      body: controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : controller.questions.isEmpty
              ? Center(child: Text('Nenhuma pergunta disponível'))
              : ListView.builder(
                  itemCount: controller.questions.length,
                  itemBuilder: (context, index) {
                    final question = controller.questions[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(question.question),
                        subtitle: question.answer != null
                            ? Text('Resposta: ${question.answer}')
                            : Text('Aguardando resposta...'),
                        trailing: question.answer == null
                            ? IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminAnswerScreen(question: question),
                                    ),
                                  );
                                  if (result == true) {
                                    setState(() {});
                                  }
                                },
                              )
                            : null,
                      ),
                    );
                  },
                ),
    );
  }
}

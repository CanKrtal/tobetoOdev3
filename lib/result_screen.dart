import 'package:flutter/material.dart';
import 'package:deneme/models/question.dart';

class ResultScreen extends StatelessWidget {
  final List<Question> questions;
  final List<String?> userAnswers;

  const ResultScreen({
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text('Sonuçlar'),
      ),
      body: AlertDialog(
        scrollable: true,
        title: Text('Sonuçlar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            questions.length,
            (index) {
              final isCorrect = userAnswers[index] ==
                  questions[index].answers
                      .firstWhere((answer) => answer.isCorrect)
                      .answer;
              return ListTile(
                title: Text(
                  'Soru ${index + 1}: ${isCorrect ? "Doğru" : "Yanlış"}',
                  style: TextStyle(
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Kapat'),
          ),
        ],
      ),
    );
  }
}
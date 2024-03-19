import 'package:flutter/material.dart';
import 'package:deneme/models/question.dart';
import 'data/question_data.dart';
import 'result_screen.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _questionIndex = 0;
  List<Question> _questions = questions;
  List<String?> _userAnswers = List.filled(questions.length, null);

  void _nextQuestion() {
    setState(() {
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
      } else {
        _showResults();
      }
    });
  }

  void _prevQuestion() {
    setState(() {
      if (_questionIndex > 0) {
        _questionIndex--;
      }
    });
  }

  void _saveAnswer(String answer) {
    setState(() {
      _userAnswers[_questionIndex] = answer;
    });
  }

  void _showResults() {
    showResults();
  }

  void showResults() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          questions: _questions,
          userAnswers: _userAnswers,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text('Sorular'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Soru ${_questionIndex + 1}/${_questions.length}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Text(
            _questions[_questionIndex].question,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ..._questions[_questionIndex].answers.map((answer) {
            return ElevatedButton(
              onPressed: () {
                _saveAnswer(answer.answer);
                _nextQuestion();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
              child: Text(answer.answer),
            );
              TextStyle(color: Colors.white);
          }).toList(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (_questionIndex > 0)
                ElevatedButton(
                  onPressed: _prevQuestion,
                  child: const Text('Önceki Soru'),
                ),
              if (_questionIndex < _questions.length - 1)
                ElevatedButton(
                  onPressed: _nextQuestion,
                  child: const Text('Sonraki Soru'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
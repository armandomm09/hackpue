// quiz_chat.dart
/*
import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/chat/quiz/AI/questionModel.dart';
import 'package:hackpue/pages/chat/quiz/AI/questionTabAI.dart';
import 'package:hackpue/pages/chat/quiz/questionTab.dart';
import 'dart:convert';

class quizChat extends StatefulWidget {
  const quizChat({super.key});

  @override
  State<quizChat> createState() => _quizChatState();
}

class _quizChatState extends State<quizChat> {
  final String jsonString = '''
  {
    "questions": [
      {
        "question_number": 1,
        "question_text": "¿Qué es una derivada en matemáticas?",
        "options": {
          "Una medida de cómo una función cambia a medida que su entrada cambia": true,
          "Una medida de la integral de una función": false,
          "Una medida de la constante de una función": false
        }
      },
      {
        "question_number": 2,
        "question_text": "¿Cómo se describe matemáticamente la derivada de una función?",
        "options": {
          "Describe la tasa de cambio instantáneo en un punto dado": true,
          "Describe la integral de la función en todo su dominio": false,
          "Describe la constante de la función en un intervalo dado": false
        }
      },
      {
        "question_number": 3,
        "question_text": "¿Qué variable considera la derivada en matemáticas?",
        "options": {
          "La variable independiente": true,
          "La variable dependiente": false,
          "La constante de la función": false
        }
      },
      {
        "question_number": 4,
        "question_text": "¿Qué mide la derivada de una función matemáticamente?",
        "options": {
          "La tasa de cambio instantáneo en un punto dado": true,
          "El área bajo la curva de la función": false,
          "La constante de la función en un intervalo dado": false
        }
      },
      {
        "question_number": 5,
        "question_text": "¿Cómo se relaciona la derivada con la función original?",
        "options": {
          "Describe la pendiente de la función original en un punto": true,
          "Describe el área bajo la curva de la función original": false,
          "Describe la constante de la función original en un intervalo dado": false
        }
      }
    ]
  }
  ''';

  late final Quiz quiz;

  @override
  void initState() {
    super.initState();
    quiz = Quiz.fromJson(jsonDecode(jsonString));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: quiz.questions.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Quiz',
              style: TextStyle(fontSize: 20),
            ),
            backgroundColor: backgroundGlobal,
            bottom: TabBar(
              dividerHeight: 3,
              dividerColor: Colors.grey[40],
              indicatorColor: lavender,
              tabAlignment: TabAlignment.center,
              tabs: List.generate(
                  quiz.questions.length,
                  (index) => Tab(
                        icon: Icon(
                          Icons.question_mark,
                          color: lavender,
                        ),
                      )),
            ),
          ),
          body: TabBarView(
            children: quiz.questions.map((question) {
              return QuestionTab(question: question);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/chat/quiz/AI/questionModel.dart';
import 'package:hackpue/pages/chat/quiz/AI/questionTabAI.dart';
import 'dart:convert';

class quizChat extends StatefulWidget {
  const quizChat({Key? key}) : super(key: key);

  @override
  State<quizChat> createState() => _quizChatState();
}

class _quizChatState extends State<quizChat> {
  late final Quiz quiz;
  late List<bool?> questionResults; // Track correctness of each question

  static const String jsonString = '''
  {
    "questions": [
      {
        "question_number": 1,
        "question_text": "¿Qué es una derivada en matemáticas?",
        "options": {
          "Una medida de cómo una función cambia a medida que su entrada cambia": true,
          "Una medida de la integral de una función": false,
          "Una medida de la constante de una función": false
        }
      },
      {
        "question_number": 2,
        "question_text": "¿Cómo se describe matemáticamente la derivada de una función?",
        "options": {
          "Describe la tasa de cambio instantáneo en un punto dado": true,
          "Describe la integral de la función en todo su dominio": false,
          "Describe la constante de la función en un intervalo dado": false
        }
      },
      {
        "question_number": 3,
        "question_text": "¿Qué variable considera la derivada en matemáticas?",
        "options": {
          "La variable independiente": true,
          "La variable dependiente": false,
          "La constante de la función": false
        }
      },
      {
        "question_number": 4,
        "question_text": "¿Qué mide la derivada de una función matemáticamente?",
        "options": {
          "La tasa de cambio instantáneo en un punto dado": true,
          "El área bajo la curva de la función": false,
          "La constante de la función en un intervalo dado": false
        }
      },
      {
        "question_number": 5,
        "question_text": "¿Cómo se relaciona la derivada con la función original?",
        "options": {
          "Describe la pendiente de la función original en un punto": true,
          "Describe el área bajo la curva de la función original": false,
          "Describe la constante de la función original en un intervalo dado": false
        }
      }
    ]
  }
  ''';

  @override
  void initState() {
    super.initState();
    quiz = Quiz.fromJson(jsonDecode(jsonString));
    questionResults = List.filled(quiz.questions.length, null);
  }

  void _checkAnswer(int questionIndex, bool isCorrect) {
    setState(() {
      questionResults[questionIndex] = isCorrect;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: quiz.questions.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Quiz',
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: backgroundGlobal,
            bottom: TabBar(
              // Tab bar with tabs generated based on quiz questions
              indicatorColor: lavender,
              tabs: List.generate(
                quiz.questions.length,
                (index) {
                  IconData icon;
                  Color iconColor;
                  if (questionResults[index] == true) {
                    icon = Icons.sentiment_very_satisfied; // Happy face icon
                    iconColor = pink;
                  } else if (questionResults[index] == false) {
                    icon = Icons.sentiment_very_dissatisfied; // Sad face icon
                    iconColor = deepPurple;
                  } else {
                    icon = Icons.question_answer; // Default icon
                    iconColor = lavender;
                  }
                  return Tab(
                    icon: Icon(
                      icon,
                      color: iconColor,
                    ),
                  );
                },
              ),
            ),
          ),
          body: TabBarView(
            // Tab bar view to display each question in a separate tab
            children: quiz.questions.map((question) {
              return QuestionTab(
                question: question,
                onAnswered: (isCorrect) => _checkAnswer(
                  quiz.questions.indexOf(question),
                  isCorrect,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

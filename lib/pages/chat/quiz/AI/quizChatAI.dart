import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/chat/quiz/AI/questionModel.dart';
import 'package:hackpue/pages/chat/quiz/AI/questionTabAI.dart';
import 'package:hackpue/pages/chat/quiz/questionTab.dart';
import 'dart:convert';

import 'package:hackpue/services/chat/chatWithGpt.dart';

class quizChat extends StatefulWidget {
  const quizChat({Key? key}) : super(key: key);

  @override
  State<quizChat> createState() => _quizChatState();
}

class _quizChatState extends State<quizChat> {
  late Quiz quiz = Quiz(questions: []); // Valor por defecto para quiz
  late List<bool?> questionResults = [];
  late int correctCount = 0; // Valor por defecto para questionResults

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    var newQuiz = await GPTService.getThemeQuiz();
    if (newQuiz != "Error") {
      print(newQuiz['questions']);

      var quizToSolve = {'questions': newQuiz['questions']};
      setState(() {
        quiz = Quiz.fromJson(quizToSolve);
        questionResults = List.filled(quiz.questions.length, null);
      });
    }
  }

  void _checkAnswer(int questionIndex, bool isCorrect) {
    setState(() {
      questionResults[questionIndex] = isCorrect;
      if (isCorrect) {
        setState(() {
          correctCount += 1;
        });
      }
    });
  }

  int _correctCount() {
    return correctCount;
  }

  @override
  Widget build(BuildContext context) {
    // Comprobación condicional para asegurarse de que el quiz tiene preguntas antes de construir la UI
    if (quiz.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
          backgroundColor: backgroundGlobal,
        ),
        body: Center(
          child:
              CircularProgressIndicator(), // Mostrar un indicador de carga mientras se cargan los datos
        ),
      );
    }

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
              tabAlignment: TabAlignment.center,
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
                    icon = Icons.question_mark; // Default icon
                    iconColor = happyOrange;
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
                correctCount: _correctCount(),
                currentIndex: quiz.questions.indexOf(question),
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

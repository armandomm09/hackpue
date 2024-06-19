import 'package:flutter/material.dart';
import 'package:hackpue/components/appButton.dart'; // Adjust the import as needed
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/chat/quiz/AI/questionModel.dart';
import 'package:hackpue/pages/chat/quiz/quizResult.dart'; // Adjust the import as needed

class QuestionTab extends StatefulWidget {
  final Question question;
  final Function(bool) onAnswered;
  final bool? isCorrect;
  final int currentIndex;
  final int correctCount;

  const QuestionTab({
    Key? key,
    required this.question,
    required this.onAnswered,
    this.isCorrect,
    required this.currentIndex,
    required this.correctCount,
  }) : super(key: key);

  @override
  State<QuestionTab> createState() => _QuestionTabState();
}

class _QuestionTabState extends State<QuestionTab> {
  String? currentOption;
  bool? isCorrect;
  int correctCount = 0;

  /*
  void _checkAnswerBien () {
    setState(() {
      isCorrect = widget.question.options[currentOption] ?? false;
      widget.onAnswered(isCorrect ?? false);
    });
  }*/

  void _checkAnswer() {
    setState(() {
      if (widget.question.options.containsKey(currentOption)) {
        isCorrect = widget.question.options[currentOption]!;
        correctCount += 1;
      } else {
        isCorrect = false;
      }

      widget.onAnswered(isCorrect!);
    });
  }

  Widget _displayButton(int index) {
    if (index == 4) {
      return AppButton(
        text: 'Terminar',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => quizResultPage(
                        result: widget.correctCount.toString(),
                      )));
        },
      );
    } else {
      return AppButton(
        text: '¡Verificar!',
        onPressed: _checkAnswer,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGlobal,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            // Use SingleChildScrollView to ensure scrollable content
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pregunta ${widget.question.questionNumber.toString()}',
                  style: TextStyle(
                      fontSize: 20,
                      color: lavender,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.question.questionText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: widget.question.options.keys.map((option) {
                    bool? optionCorrect = isCorrect != null
                        ? widget.question.options[option]
                        : null;
                    return ListTile(
                      title: Text(option),
                      leading: Radio<String>(
                        value: option,
                        groupValue: currentOption,
                        onChanged: (value) {
                          setState(() {
                            currentOption = value;
                          });
                        },
                      ),
                      trailing: isCorrect != null
                          ? Icon(
                              optionCorrect == true ? Icons.check : Icons.close,
                              color: optionCorrect == true
                                  ? Colors.green
                                  : Colors.red,
                            )
                          : null,
                    );
                  }).toList(),
                ),
                SizedBox(height: 20),
                _displayButton(widget.currentIndex),
                //Text(correctCount.toString())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

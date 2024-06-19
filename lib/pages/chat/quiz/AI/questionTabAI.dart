import 'package:flutter/material.dart';
import 'package:hackpue/components/appButton.dart'; // Adjust the import as needed
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/chat/quiz/AI/questionModel.dart'; // Adjust the import as needed

class QuestionTab extends StatefulWidget {
  final Question question;
  final Function(bool) onAnswered;
  final bool? isCorrect;

  const QuestionTab({
    Key? key,
    required this.question,
    required this.onAnswered,
    this.isCorrect,
  }) : super(key: key);

  @override
  State<QuestionTab> createState() => _QuestionTabState();
}

class _QuestionTabState extends State<QuestionTab> {
  String? currentOption;
  bool? isCorrect;

  void _checkAnswer() {
    setState(() {
      isCorrect = widget.question.options[currentOption] ?? false;
      widget.onAnswered(isCorrect ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGlobal,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          // Use SingleChildScrollView to ensure scrollable content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.question.questionText,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
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
              ),
              SizedBox(height: 20),
              AppButton(
                text: 'Check Answer',
                onPressed: _checkAnswer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

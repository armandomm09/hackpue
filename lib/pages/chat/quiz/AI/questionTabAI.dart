// question_tab.dart
import 'package:flutter/material.dart';
// Import the model classes
import 'package:hackpue/components/appButton.dart'; // Adjust the import as needed
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/chat/quiz/AI/questionModel.dart'; // Adjust the import as needed

class QuestionTab extends StatefulWidget {
  final Question question;
  const QuestionTab({super.key, required this.question});

  @override
  State<QuestionTab> createState() => _QuestionTabState();
}

class _QuestionTabState extends State<QuestionTab> {
  String? currentOption;

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
                padding: const EdgeInsets.symmetric(
                    horizontal: 20), // Adjust the padding for better fit
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: widget.question.options.keys.map((option) {
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
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              AppButton(
                text: 'Send',
                onPressed: () {
                  // Handle send action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

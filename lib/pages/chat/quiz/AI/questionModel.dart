// quiz_model.dart

/*
class Quiz {
  final List<Question> questions;

  Quiz({required this.questions});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    var list = json['questions'] as List;
    List<Question> questionList =
        list.map((i) => Question.fromJson(i)).toList();
    return Quiz(questions: questionList);
  }
}

class Question {
  final int questionNumber;
  final String questionText;
  final Map<String, bool> options;

  Question({
    required this.questionNumber,
    required this.questionText,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionNumber: json['question_number'],
      questionText: json['question_text'],
      options: Map<String, bool>.from(json['options']),
    );
  }

  get selectedOption => null;
}
*/
// quiz_model.dart

class Quiz {
  final List<Question> questions;

  Quiz({required this.questions});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    var list = json['questions'] as List;
    List<Question> questionList =
        list.map((i) => Question.fromJson(i)).toList();
    return Quiz(questions: questionList);
  }
}

class Question {
  final int questionNumber;
  final String questionText;
  final Map<String, bool> options;
  bool answeredCorrectly;

  Question({
    required this.questionNumber,
    required this.questionText,
    required this.options,
    this.answeredCorrectly = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionNumber: json['question_number'],
      questionText: json['question_text'],
      options: Map<String, bool>.from(json['options']),
      answeredCorrectly: false,
    );
  }
}

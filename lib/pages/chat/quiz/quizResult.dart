import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';

class quizResultPage extends StatelessWidget {
  final String result;
  quizResultPage({super.key, required this.result});

  List<String> titleRetro = [
    "Felicidades",
    "¡Bien hecho!",
    "¡No te preocupes!"
  ];

  List<String> messages = [
    "Lo estás haciendo increíble. ¡Sigue así!",
    "No te desanimes, sigue reforzando estos conceptos para mejorar a la próxima.",
    "¿Este tema sigue sin quedarte claro? Vuelve a repasar y ¡nos vemos de nuevo!"
  ];

  String title() {
    if (result == '5' || result == '4') {
      return titleRetro.first;
    } else if (result == '3' || result == '2') {
      return titleRetro[1];
    } else {
      return titleRetro.last;
    }
  }

  String message() {
    if (result == '5' || result == '4') {
      return messages.first;
    } else if (result == '3' || result == '2') {
      return messages[1];
    } else {
      return messages.last;
    }
  }

  String fact() {
    if (result == '5' || result == '4') {
      return 'Obtuviste $result respuestas correctas!';
    } else if (result == '3' || result == '2') {
      return 'Obtuviste $result respuestas correctas!';
    } else {
      return 'Obtuviste $result respuesta correctas!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          appBar: AppBar(),
          backgroundColor: happyYellow,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title(),
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Obtuviste $result respuestas correctas!'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    message(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

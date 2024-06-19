import 'package:flutter/material.dart';
import 'package:hackpue/components/appButton.dart';
import 'package:hackpue/constants.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hackpue/pages/app_intro/mainPage.dart';
import 'package:hackpue/pages/app_intro/services.dart';
import 'package:hackpue/pages/chat/chat_with_database.dart';

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
                  )
                      .animate(delay: Duration(milliseconds: 300))
                      .flip(duration: Duration(milliseconds: 200)),
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
                  SizedBox(
                    height: 30,
                  ),
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(lavender)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatWithDatabase()));
                          },
                          child: Text(
                            '¡Quiero mejorar!',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                            .animate(delay: Duration(seconds: 2))
                            .shake(delay: Duration(seconds: 1))
                            .shake(delay: Duration(milliseconds: 100)),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AppServices()));
                          },
                          child: Text(
                            'Volver',
                            style: TextStyle(color: deepPurple),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(happyOrange)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

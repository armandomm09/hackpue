import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hackpue/components/appButton.dart';
import 'package:hackpue/components/my_carousel_item.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/app_intro/services.dart';
import 'package:hackpue/pages/askUserInfo.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Bienvenido a la plataforma de aprendizaje con IA',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: deepPurple,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    'Esta aplicación te ayudará a mejorar tus habilidades de aprendizaje con la ayuda de la inteligencia artificial.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: defaultText,
                    ),
                  ),

                  const SizedBox(height: 40),
                  AppButton(
                    text: 'Siguiente',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppServices(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  // Agregar más widgets aquí según sea necesario
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

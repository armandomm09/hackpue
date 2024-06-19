import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hackpue/components/materialApp/appDrawer.dart';
import 'package:hackpue/components/myCarrouselDemo.dart';
import 'package:hackpue/components/my_carousel_item.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/askUserInfo.dart';
import 'package:hackpue/pages/chat/chat_with_database.dart';
import 'package:hackpue/pages/chat/firstChatPromt.dart';
import 'package:hackpue/pages/chat/quiz/quizResult.dart';
import 'package:hackpue/pages/chat/uploadFile.dart';
import 'package:hackpue/pages/chat/upload_audio.dart';

class DemoAppServices extends StatelessWidget {
  const DemoAppServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '¡Conoce a tus nuevos aliados!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          color: deepPurple,
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Text(
                    'En tu día a día estudiantil',
                    style: TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  CarouselSlider(
                    items: [
                      MyCarouselDemo(
                        isDemo: true,
                        gradientColor: pink,
                        title: 'Mosaic GPT',
                      ),
                      MyCarouselDemo(
                        isDemo: true,
                        gradientColor: lavender,
                        title: 'Subir un Archivo',
                      ),
                      MyCarouselDemo(
                        isDemo: true,
                        gradientColor: happyYellow,
                        title: 'Grabar Audio',
                      ),
                    ],
                    options: CarouselOptions(
                      height: 200,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.8,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(happyYellow)),
                    onPressed: () {
                      // Navegar a la pantalla de formulario
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserInfoFormScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'I like it!',
                      style: TextStyle(
                          color: lavender, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
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

// Pantalla para Chatear con ChatGPT

// Pantalla para Subir un Archivo
class UploadFileScreen extends StatelessWidget {
  const UploadFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir un Archivo'),
        backgroundColor: lavender,
      ),
      body: const Center(
        child: Text(
          'Pantalla de Subir Archivo aquí',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

// Pantalla para Grabar Audio
class RecordAudioScreen extends StatelessWidget {
  const RecordAudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask with voice'),
        backgroundColor: lavender,
      ),
      body: const Center(
        child: Text(
          'Pantalla de Grabar Audio aquí',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

// Pantalla para el Formulario de Información del Usuario

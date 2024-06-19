import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hackpue/components/my_carousel_item.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/askUserInfo.dart';
import 'package:hackpue/pages/chat/chat_with_database.dart'; // Asegúrate de tener este archivo


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myBackGroundColor,
      appBar: AppBar(
        title: Text(
          'HACK PUE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: myTitleColor
          ),
        ),
        backgroundColor: appBarBackgorundColor
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Bienvenido a la plataforma de aprendizaje con IA',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Esta aplicación te ayudará a mejorar tus habilidades de aprendizaje con la ayuda de la inteligencia artificial.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 30),
              CarouselSlider(
                items: [
                  MyCarouselItem(
                    title: 'Chatear con ChatGPT',
                    onTap: () {
                      // Navegar a la pantalla de ChatGPT
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChatWithDatabase(),
                        ),
                      );
                    },
                  ),
                  MyCarouselItem(
                    title: 'Subir un Archivo',
                    onTap: () {
                      // Navegar a la pantalla de subir archivo
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UploadFileScreen(),
                        ),
                      );
                    },
                  ),
                  MyCarouselItem(
                    title: 'Grabar Audio',
                    onTap: () {
                      // Navegar a la pantalla de grabar audio
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecordAudioScreen(),
                        ),
                      );
                    },
                  ),
                ],
                options: CarouselOptions(
                  height: 200,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  aspectRatio: 16/9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navegar a la pantalla de formulario
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserInfoFormScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 28, 48, 225), // Fondo del botón
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Let us know you'),
              ),
              const SizedBox(height: 20),
              // Agregar más widgets aquí según sea necesario
            ],
          ),
        ),
      ),
    );
  }
}

// Pantalla para Chatear con ChatGPT
class ChatGPTScreen extends StatelessWidget {
  const ChatGPTScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat con ChatGPT'),
        backgroundColor: const Color.fromARGB(255, 45, 36, 63),
      ),
      body: const Center(
        child: Text(
          'Pantalla de ChatGPT aquí',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

// Pantalla para Subir un Archivo
class UploadFileScreen extends StatelessWidget {
  const UploadFileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir un Archivo'),
        backgroundColor: const Color.fromARGB(255, 45, 36, 63),
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
        title: const Text('Grabar Audio'),
        backgroundColor: const Color.fromARGB(255, 45, 36, 63),
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

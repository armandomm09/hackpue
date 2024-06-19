import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hackpue/components/my_carousel_item.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/askUserInfo.dart';
import 'package:hackpue/pages/chat/firstChatPromt.dart'; // Asegúrate de tener este archivo

class appServices extends StatelessWidget {
  const appServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text(
            'HACK PUE',
            style: TextStyle(fontWeight: FontWeight.bold, color: deepPurple),
          ),
          backgroundColor: Colors.deepPurple),
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
                      'Conoce a tus nuevos aliados',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: deepPurple,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Text(
                    'En tu día a día estudiantil',
                    style: TextStyle(fontSize: 18),
                  ),

                  const SizedBox(height: 10),

                  CarouselSlider(
                    items: [
                      MyCarouselItem(
                        title: 'Chatear con ChatGPT',
                        onTap: () {
                          // Navegar a la pantalla de ChatGPT
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FirstPromptChat(),
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
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.8,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(happyYellow)),
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
        title: const Text('Grabar Audio'),
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

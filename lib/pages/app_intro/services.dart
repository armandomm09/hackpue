import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hackpue/components/materialApp/appDrawer.dart';
import 'package:hackpue/components/my_carousel_item.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/askUserInfo.dart';
import 'package:hackpue/pages/chat/chat_with_database.dart';
import 'package:hackpue/pages/chat/firstChatPromt.dart';
import 'package:hackpue/pages/chat/uploadFile.dart';
import 'package:hackpue/pages/chat/upload_audio.dart';

class AppServices extends StatelessWidget {
  const AppServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
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
                              builder: (context) => AskGPTWithFile(),
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
                              builder: (context) => AudioToTextPage(),
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

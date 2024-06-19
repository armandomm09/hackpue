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
            'Home',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: backgroundGlobal),
          ),
          backgroundColor: lavender),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/fondoblanco.png'),
                    width: 200,
                  ),

                  const SizedBox(height: 50),

                  CarouselSlider(
                    items: [
                      MyCarouselItem(
                        icon: Icons.message,
                        isDemo: false,
                        gradientColor: happyOrange,
                        title: 'Mosaic GPT',
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
                        icon: Icons.upload_file_rounded,
                        isDemo: false,
                        gradientColor: lavender,
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
                        icon: Icons.record_voice_over_sharp,
                        isDemo: false,
                        gradientColor: happyYellow,
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

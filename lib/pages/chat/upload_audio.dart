import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:hackpue/components/appButton.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/chat/chat_with_database.dart';
import 'package:record/record.dart';
import 'package:http/http.dart' as http;

class AudioToTextPage extends StatefulWidget {
  @override
  State<AudioToTextPage> createState() => _AudioToTextPageState();
}

class _AudioToTextPageState extends State<AudioToTextPage> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  String convertedText = 'Text';
  bool isRecording = false;
  bool isListening = false;
  String audioPath = '';

  @override
  void initState() {
    super.initState();
    audioRecord = Record();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerComplete.listen((_) => audioCompletionListener());
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    audioRecord.dispose();
    super.dispose();
  }

  Future<String> speechToText(String filePath) async {
    try {
      const apiKey =
          'sk-proj-CCGa043OAmNNG4HgUFxET3BlbkFJ4WKsVsU1ZGM0B2nZ7v6d'; // Reemplaza con tu clave API
      var url = Uri.https('api.openai.com', '/v1/audio/transcriptions');
      var request = http.MultipartRequest("POST", url);
      request.headers.addAll(({"Authorization": "Bearer $apiKey"}));
      request.fields['model'] = 'whisper-1';
      request.fields['language'] = 'es';
      request.fields['response_format'] = 'verbose_json';
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var response = await request.send();
      var newResponse = await http.Response.fromStream(response);

      final responseData = json.decode(utf8.decode(newResponse.bodyBytes));
      print(responseData);
      return responseData['text'];
    } catch (e) {
      print("Error al procesar la solicitud: $e");
      return "Error al procesar la solicitud";
    }
  }

  Widget showIconRecord(bool isListening) {
    if (isListening) {
      return Icon(
        Icons.mic,
        color: lavender,
      );
    } else {
      return Icon(
        Icons.mic_none,
        color: happyYellow,
      );
    }
  }

  Widget showIconListen(bool isListening) {
    if (isListening) {
      return Icon(
        Icons.volume_down,
        color: lavender,
      );
    } else {
      return Icon(
        Icons.volume_mute,
        color: happyYellow,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: pink,
        title: Text(
          'Confidence:',
          style: TextStyle(color: defaultText),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleChildScrollView(
              reverse: true,
              //padding: const EdgeInsets.fromLTRB(0.0, 30.0, 30.0, 150.0),
              child: Container(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Text(
                  convertedText,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: defaultText,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton(
                    text: 'Send',
                    onPressed: () {
                      print('Text: ' + convertedText);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatWithDatabase(
                            initialQuestion: convertedText,
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AvatarGlow(
                          animate: isRecording,
                          glowColor: pink,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(10)),
                                fixedSize:
                                    MaterialStatePropertyAll(Size(60, 60)),
                                backgroundColor: isRecording
                                    ? MaterialStatePropertyAll(happyOrange)
                                    : MaterialStatePropertyAll(lavender)),
                            onPressed: isRecording
                                ? () => stopRecording()
                                : () => startRecording(),
                            child: showIconRecord(isRecording),
                          ),
                        ),
                        AvatarGlow(
                          animate: isRecording,
                          glowColor: pink,
                          duration: const Duration(milliseconds: 2000),
                          repeat: true,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(10)),
                              fixedSize: MaterialStatePropertyAll(Size(60, 60)),
                              backgroundColor: isRecording
                                  ? MaterialStatePropertyAll(happyOrange)
                                  : MaterialStatePropertyAll(lavender),
                            ),
                            onPressed: startListeningRecording,
                            child: showIconListen(isListening),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: 90,),
          ],
        ),
      ),
    );
  }

  void audioCompletionListener() {
    setState(() {
      isListening = false;
    });
  }

  Future<void> startListeningRecording() async {
    try {
      print('Playing...');
      Source source = UrlSource(audioPath);
      setState(() {
        isListening = true;
      });
      await audioPlayer.play(source);
    } catch (e) {
      setState(() {
        isListening = false;
      });
      print('Error while playing audio... $e');
    }
  }

  Future<void> stopListeningRecording() async {
    try {
      print('Stopped listening');
      setState(() {
        isListening = false;
      });
      await audioPlayer.stop();
    } catch (e) {
      setState(() {
        isListening = true;
      });
    }
  }

  void startRecording() async {
    print('HOLA');
    try {
      if (await audioRecord.hasPermission()) {
        audioRecord.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('Error recording: $e');
    }
  }

  void stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        audioPath = path!;
      });
      String? newText = await speechToText(path!.substring(7));
      setState(() {
        convertedText = newText;
      });
    } catch (e) {
      print('Error stopping recorder $e');
    }
  }
}

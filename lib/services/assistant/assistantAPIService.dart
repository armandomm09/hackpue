import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackpue/models/gpt_message.dart';
import 'package:hackpue/models/userInfo.dart';
import 'package:hackpue/services/chat/chatWithGpt.dart';
import 'package:hackpue/services/userInfo/UserInfoService.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
class AssistantAPIService {

  static Future<dynamic> sendMessage(GptMessage message) async {
    print("fetching..");
    var url = "http://live.galliard.mx/api/v1/gpt_response";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json", // Añadir encabezado Content-Type
        },
        body: json.encode(message.toAPIJson()), // Convertir a JSON
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var info = jsonDecode(utf8.decode(response.bodyBytes));
        print(info.toString());
        var content = info['content'];
        for(var message in content){
          print(message['type']);
          if(message['type'] == 'paragraph'){
            await GPTService.saveGPTResponse(message['text']);
          } else if(message['type'] == 'image'){
            await AssistantAPIService.generateImage(message['description']);
          }
        }
        var generatedQuiz = await generateQuiz(info);
        print(generatedQuiz['questions'].toString());
        
        return info; // Devolver la respuesta decodificada
      } else {
        print("Failed to load events: ${response.statusCode}");
        return {"error": "Failed to load events"};
      }
    } catch (e) {
      print("Error fetching events: $e");
      return {"error": e.toString()};
    }
  }

  

  static generateQuiz(dynamic questionResponse) async {
    print("fetching..");
    var url = "http://live.galliard.mx/api/v1/generate_quizz";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json", 
        },
        body: json.encode(questionResponse), 
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var info = jsonDecode(utf8.decode(response.bodyBytes));
        var content = info['content'];

      
        await GPTService.saveThemeQuiz(info);
        
        return info; 
      } else {
        print("Failed to load events: ${response.statusCode}");
        return {"error": "Failed to load events"};
      }
    } catch (e) {
      print("Error fetching events: $e");
      return {"error": e.toString()};
    }
  }

  static generateImage(String promt) async {
    print("fetching..");
    final GptMessage message = GptMessage('chachoGPT', 'chachoGPT@chachitos.com',
        promt, Timestamp.now(), const Uuid().v1(), await UserInfoService.getAllInfo());
    var url = "http://live.galliard.mx/api/v1/generate_image";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json", // Añadir encabezado Content-Type
        },
        body: json.encode(message.toAPIJson()), // Convertir a JSON
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        var info = jsonDecode(response.body);
        var urlResponse = info['url'];
        
        await GPTService.saveGPTResponse(urlResponse);
        
        return "Succesful"; // Devolver la respuesta decodificada
      } else {
        print("Failed to load events: ${response.statusCode}");
        return {"error": "Failed to load events"};
      }
    } catch (e) {
      print("Error fetching events: $e");
      return {"error": e.toString()};
    }
  }

  static Future<void> textToSpeech(String mensaje, FlutterSoundPlayer _flutterSoundPlayer) async {
  const apiKey =
      'sk-proj-CCGa043OAmNNG4HgUFxET3BlbkFJ4WKsVsU1ZGM0B2nZ7v6d'; // Reemplaza con tu clave API
  
  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/audio/speech'), // Ajusta la URL a la correcta de la API de OpenAI TTS si es diferente
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${apiKey}',
    },
    body: jsonEncode({
      'model': "tts-1",
      'input': mensaje,
      'voice': 'alloy', // Ajusta según sea necesario
    }),
  );

  if (response.statusCode == 200) {
    // Guardar el archivo MP3 en el dispositivo
    try {
      final bytes = response.bodyBytes; // Obtener los bytes de la respuesta

      // Obtener el directorio temporal
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/output.mp3'; // Ruta para guardar el archivo

      // Guardar el archivo en la ruta especificada
      final file = File(filePath);
      await file.writeAsBytes(bytes);

      // Reproducir el archivo MP3 guardado
      await _flutterSoundPlayer.startPlayer(fromURI: filePath);
    } catch (e) {
      print('Error al guardar o reproducir el archivo MP3: $e');
    }
  } else {
    print('Error en la solicitud: ${response.statusCode}');
    print('Respuesta del servidor: ${response.body}');
  }
}


}
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackpue/models/gpt_message.dart';
import 'package:hackpue/models/userInfo.dart';
import 'package:hackpue/services/chat/chatWithGpt.dart';
import 'package:hackpue/services/userInfo/UserInfoService.dart';
import 'package:http/http.dart' as http;
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
        var info = jsonDecode(response.body);
        var content = info['content'];
        for(var message in content){
          print(message['type']);
          if(message['type'] == 'paragraph'){
            await GPTService.saveGPTResponse(message['text']);
          } else if(message['type'] == 'image'){
            await AssistantAPIService.generateImage(message['description']);
          }
        }
        
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

}
import 'dart:convert';

import 'package:hackpue/models/gpt_message.dart';
import 'package:hackpue/models/userInfo.dart';
import 'package:hackpue/services/chat/chatWithGpt.dart';
import 'package:http/http.dart' as http;
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
            GPTService.saveGPTResponse(message['text']);
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
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackpue/models/userInfo.dart';

class GptMessage {
  final String senderId;
  final String senderEmail;
  final String question;
  final String uuid;
  final Timestamp timestamp;
  final MyUserInfo userInfo;

  GptMessage(this.senderId, this.senderEmail, this.question, this.timestamp,
      this.uuid, this.userInfo);

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "senderEmail": senderEmail,
      "question": question,
      "uuid": uuid,
      "timestamp": timestamp,
    };
  }

  Map<String, dynamic> toAPIJson() {
    return {
      "prompt": question,
      "user_profile": {
        "interests": userInfo.interests.isNotEmpty ? userInfo.interests.split(", ") : [], // Asegúrate de que sea una lista
        "learning_style": ["Visual"], // Este es un valor de ejemplo, reemplázalo según corresponda
        "disability": userInfo.disabilty.isNotEmpty ? userInfo.disabilty.split(", ") : [] // Asegúrate de que sea una lista
      }
    };
  }
}
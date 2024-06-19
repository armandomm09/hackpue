import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackpue/models/gpt_message.dart';
import 'package:hackpue/models/userInfo.dart';
import 'package:hackpue/services/assistant/assistantAPIService.dart';
import 'package:hackpue/services/userInfo/UserInfoService.dart';
import 'package:uuid/uuid.dart';

enum PostState { successful, isDuplicated, serverError, clientError }

class GPTService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final String currentUserID = auth.currentUser!.uid;
  static final String currentUserEmail = auth.currentUser!.email!;

  static newGptMessage(String question) async {
    final MyUserInfo userInfo = await UserInfoService.getAllInfo();
    final GptMessage message = GptMessage(currentUserID, currentUserEmail,
        question, Timestamp.now(), const Uuid().v1(), userInfo);

    try {
      await firestore
          .collection('Users')
          .doc(currentUserEmail)
          .collection('gptChat')
          .add(message.toMap());
      print(message.toAPIJson());
      print('Sent succesfull');
      var answer = await AssistantAPIService.sendMessage(message);

      //newGPTAnswer(question);
      return PostState.successful;
    } catch (e) {
      print('Error att $e');
      return PostState.serverError;
    }
  }

  static saveThemeQuiz(dynamic quiz) async {
    try {
      await firestore
          .collection('Users')
          .doc(currentUserEmail)
          .collection('gptChat')
          .doc('Quiz')
          .set(quiz);
      print('Sent succesfull');

      //newGPTAnswer(question);
      return PostState.successful;
    } catch (e) {
      print('Error att $e');
      return PostState.serverError;
    }
  }

  static getThemeQuiz() async {
    try {
      var info = await firestore
          .collection('Users')
          .doc(currentUserEmail)
          .collection('gptChat')
          .doc('Quiz')
          .get();
      print('Sent succesfull');

      //newGPTAnswer(question);
      return info;
    } catch (e) {
      print('Error att $e');
      return 'Error';
    }
  }

  static saveGPTResponse(String answer) async {
    final GptMessage message = GptMessage(
        'chachoGPT',
        'chachoGPT@chachitos.com',
        answer,
        Timestamp.now(),
        const Uuid().v1(),
        MyUserInfo('disabilty', 'hobbies', 'edad', 'study', 'interests'));

    try {
      await firestore
          .collection('Users')
          .doc(currentUserEmail)
          .collection('gptChat')
          .add(message.toMap());
      print('Sent succesfull');

      //newGPTAnswer(question);
      return PostState.successful;
    } catch (e) {
      print('Error att $e');
      return PostState.serverError;
    }
  }

  static Stream<QuerySnapshot> getMessages() {
    return firestore
        .collection("Users")
        .doc(currentUserEmail)
        .collection("gptChat")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}

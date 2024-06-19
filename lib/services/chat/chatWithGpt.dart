import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackpue/models/gpt_message.dart';
import 'package:uuid/uuid.dart';

enum PostState { successful, isDuplicated, serverError, clientError}


class GPTService {


  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final String currentUserID = auth.currentUser!.uid;
  static final String currentUserEmail= auth.currentUser!.email!;
  
  static newGptMessage(String question) async {

    final GptMessage message = GptMessage(currentUserID, currentUserEmail, question, Timestamp.now(), const Uuid().v1());

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
      print('Error at $e');
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
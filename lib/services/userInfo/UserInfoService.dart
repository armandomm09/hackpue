import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackpue/models/userInfo.dart';
import 'package:hackpue/services/chat/chatWithGpt.dart';

class UserInfoService {

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final String currentUserID = auth.currentUser!.uid;
  static final String currentUserEmail= auth.currentUser!.email!;

  static saveUserInfo(MyUserInfo userInfo) async {

    try {
      await firestore
      .collection('Users')
      .doc(currentUserEmail)
      .collection('userInfo')
      .doc("userInfo")
      .set(userInfo.toJson());
      print('Sent succesfull');
      //newGPTAnswer(question);
      return PostState.successful;
    } catch (e) {
      print('Error at $e');
      return PostState.serverError;
    }
  }
}
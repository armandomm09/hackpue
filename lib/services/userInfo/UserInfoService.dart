import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackpue/models/userInfo.dart';
import 'package:hackpue/services/chat/chatWithGpt.dart';
enum UserSpecificInfo{
  Disability, Hobbies, Age, Studies, Interests
}
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

  String userSpecificInfoToString(UserSpecificInfo info) {
    switch (info) {
      case UserSpecificInfo.Disability:
        return "disability";
      case UserSpecificInfo.Hobbies:
        return "hobbies";
      case UserSpecificInfo.Age:
        return "age";
      case UserSpecificInfo.Studies:
        return "studies";
      case UserSpecificInfo.Interests:
        return "interests";
      default:
        return '';
    }
  }

  static Future<dynamic> getSpecificInfo(UserSpecificInfo infoToGet) async {
    try {
      var response = await firestore
          .collection('Users')
          .doc(currentUserEmail)
          .collection('userInfo')
          .doc("userInfo")
          .get();

      if (response.exists) {
        String infoKey = UserInfoService().userSpecificInfoToString(infoToGet);
        print(response[infoKey]);
        return response[infoKey];
      } else {
        print('Document does not exist');
        return 'Document does not exist';
      }
    } catch (e) {
      print('Error at $e');
      return 'Error at e';
    }
  }
}
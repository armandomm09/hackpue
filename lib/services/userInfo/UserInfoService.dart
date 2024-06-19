
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

  static Future<PostState> resetConversation() async {
    try {
      QuerySnapshot querySnapshot = await firestore
      .collection('Users')
      .doc(currentUserEmail)
      .collection('gptChat')
      .get();

  // Iterate over each document and delete it
  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    await firestore.collection('Users').doc(currentUserEmail).collection('gptChat').doc(doc.id).delete();
  }
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

  static Future<MyUserInfo> getAllInfo() async {
    try {
      
        MyUserInfo userInfo = MyUserInfo(
          await UserInfoService.getSpecificInfo(UserSpecificInfo.Disability), 
          await UserInfoService.getSpecificInfo(UserSpecificInfo.Hobbies),  
          await UserInfoService.getSpecificInfo(UserSpecificInfo.Age), 
          await UserInfoService.getSpecificInfo(UserSpecificInfo.Studies), 
          await UserInfoService.getSpecificInfo(UserSpecificInfo.Interests), 
          );
        return userInfo;
     
    } catch (e) {
      print('Error atA $e');
      return MyUserInfo('n/a', 'n/a', 'n/a', 'n/a', 'n/a');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmail(String email, password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      firestore.collection("Users").doc(userCredential.user!.uid).set(
      {
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      print("Email:" + email);
      print('Excecpciob nuymero: '+ e.code.toString());
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, password) async {
    
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      firestore.collection("Users").doc(userCredential.user!.uid).set(
      {
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email
      }
    );

      return userCredential;

      
    } on FirebaseAuthException catch (e) {
      print('Excecpciob nuymero: '+ e.code.toString());
      throw Exception(e.code);
    }

    
  }

  Future<void> signOut() async{
    return await auth.signOut();
  }

  User? getCurrentUser(){
    return auth.currentUser;
  }
}
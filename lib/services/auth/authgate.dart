import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackpue/main.dart';
import 'package:hackpue/pages/app_intro/services.dart';
import 'package:hackpue/services/auth/login_or_register.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const appServices(); //TeamDetails( teamNickname: "Imperator", team: "5887", eventKey: "2024mxpu");
            } else {
              return const LoginOrRegisterPage();
            }
          }),
    );
  }
}

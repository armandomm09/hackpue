import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/firebase_options.dart';
import 'package:hackpue/pages/app_intro/gradient.dart';
import 'package:hackpue/pages/app_intro/mainPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hackpue/pages/app_intro/services.dart';
import 'package:hackpue/pages/chat/chat_with_database.dart';
import 'package:hackpue/pages/chat/firstChatPromt.dart';
import 'package:hackpue/pages/chat/upload_audio.dart';
import 'package:hackpue/pages/servicesDemoPage.dart';
import 'package:hackpue/pages/user_sign/login_page.dart';
import 'package:hackpue/services/auth/authgate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Dmo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: lavender),
          useMaterial3: true,
        ),
        home: StartingGradient());
  }
}

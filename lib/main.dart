import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/firebase_options.dart';
import 'package:hackpue/pages/app_intro/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hackpue/pages/app_intro/starting.dart';
import 'package:hackpue/pages/app_intro/welcome.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: deepPurple),
          useMaterial3: true,
          fontFamily: 'Inter'),
      home: const startingGradient(),
    );
  }
}

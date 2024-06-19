import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';

class startingGradient extends StatelessWidget {
  const startingGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [happyYellow, pink, lavender])),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';

class StartingGradient extends StatelessWidget {
  const StartingGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [happyYellow, pink, lavender],
            begin: Alignment.bottomLeft,
            end: Alignment.center,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.web,
                color: backgroundGlobal,
              ),
              Center(
                child: Text(
                  'chachitos.dev',
                  style: TextStyle(
                      fontSize: 40,
                      color: backgroundGlobal,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

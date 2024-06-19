import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/services/auth/authgate.dart';

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
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image(
                    image: AssetImage('assets/images/unatintablanco.png')),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AuthGate()));
                },
                child: Icon(Icons.fingerprint),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                    foregroundColor: MaterialStatePropertyAll(Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

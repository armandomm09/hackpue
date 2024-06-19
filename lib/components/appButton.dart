import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';
import 'package:hackpue/pages/askUserInfo.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const AppButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(happyYellow)),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: lavender, fontWeight: FontWeight.bold, letterSpacing: 1),
      ),
    );
  }
}
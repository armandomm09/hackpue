import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const AppButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 28, 48, 225),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              child: const Text('Guardar'),
            );
  }
}
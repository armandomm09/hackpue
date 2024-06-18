
import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';

class AppTextField extends StatelessWidget {
  final String textt;
  final void Function(String?)? onSaved;
  const AppTextField({super.key, required this.textt, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
              decoration: InputDecoration(
                labelText: textt,
                labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                filled: true,
                fillColor: formInputBackgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSaved: onSaved,
              style: const TextStyle(color: Colors.white),
            );
  }
}
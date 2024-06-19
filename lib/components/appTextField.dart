import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';

class AppTextField extends StatelessWidget {
  final desiredColor;
  final String textt;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  const AppTextField(
      {super.key,
      required this.textt,
      this.onSaved,
      this.controller,
      this.focusNode,
      this.desiredColor});

  Color returnColor() {
    if (desiredColor != defaultText) {
      return deepPurple;
    }

    return defaultText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        labelText: textt,
        labelStyle: TextStyle(color: returnColor()),
        filled: true,
        fillColor: formInputBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSaved: onSaved,
      style: TextStyle(color: returnColor()),
    );
  }
}

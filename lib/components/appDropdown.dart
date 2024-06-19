import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';

class appDropdown extends StatefulWidget {
  String defaultValue;
  final List<String> list;

  appDropdown({super.key, required this.defaultValue, required this.list});

  @override
  State<appDropdown> createState() => _appDropdownState();
}

class _appDropdownState extends State<appDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Discapacidad',
        labelStyle: TextStyle(color: deepPurple),
        filled: true,
        fillColor: formInputBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      value: widget.defaultValue,
      items: widget.list.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          widget.defaultValue = newValue!;
        });
      },
      style: TextStyle(color: defaultText),
      dropdownColor: happyYellow,
    );
  }
}

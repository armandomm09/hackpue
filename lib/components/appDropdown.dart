import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';

class appDropdown extends StatefulWidget {
  final Color? textColor;
  final double width;
  final String theme;
  final Color? dropdownColor;
  String defaultValue;
  final List<String> list;
  final Function(String?)? onChanged;

  appDropdown(
      {super.key,
      required this.defaultValue,
      required this.list,
      this.onChanged,
      required this.theme,
      this.dropdownColor,
      required this.width,
      this.textColor});

  @override
  State<appDropdown> createState() => _appDropdownState();
}

class _appDropdownState extends State<appDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: widget.theme,
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
        onChanged: widget.onChanged,
        style: TextStyle(color: widget.textColor),
        dropdownColor: widget.dropdownColor,
      ),
    );
  }
}

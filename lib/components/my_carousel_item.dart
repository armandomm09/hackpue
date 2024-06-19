import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';

class MyCarouselItem extends StatelessWidget {
  final bool isDemo;
  final Color gradientColor;
  final String title;
  final VoidCallback? onTap;
  const MyCarouselItem(
      {super.key,
      this.onTap,
      required this.title,
      required this.gradientColor,
      required this.isDemo});

  TextStyle returnTextStyle(bool isDemo) {
    if (isDemo) {
      return TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
    } else {
      return TextStyle(color: defaultText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                  colors: [gradientColor, backgroundGlobal],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topLeft)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(title, style: returnTextStyle(isDemo)),
            ),
          ),
        ),
      ),
    );
  }
}

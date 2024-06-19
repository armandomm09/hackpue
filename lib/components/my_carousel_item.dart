import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';

class MyCarouselItem extends StatelessWidget {
  final IconData icon;
  final bool isDemo;
  final Color gradientColor;
  final String title;
  final VoidCallback? onTap;
  const MyCarouselItem(
      {super.key,
      this.onTap,
      required this.title,
      required this.gradientColor,
      required this.isDemo,
      required this.icon});

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
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 120,
                color: gradientColor,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ));
  }
}

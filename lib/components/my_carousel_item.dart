import 'package:flutter/material.dart';
import 'package:hackpue/constants.dart';

class MyCarouselItem extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  const MyCarouselItem({super.key, this.onTap, required this.title});

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
                  colors: [happyYellow, backgroundGlobal],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topLeft)

              /*LinearGradient(
              colors: [happyYellow, ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )
            */
              ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  letterSpacing: 1,
                  color: defaultText,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

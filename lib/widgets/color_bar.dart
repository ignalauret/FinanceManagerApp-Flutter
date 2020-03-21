import 'package:flutter/material.dart';

class ColorBar extends StatelessWidget {
  final Color color;
  final double height;
  final bool vertical;
  final bool fixedHeight;

  ColorBar({
    this.color,
    this.height,
    this.vertical = true,
    this.fixedHeight = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: vertical ? (fixedHeight ? height : null) : 5,
      width: vertical ? 5 : (fixedHeight ? height : null),
      margin: EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 7,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

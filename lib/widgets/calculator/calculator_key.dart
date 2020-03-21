import '../../utils/constants.dart';
import 'package:flutter/material.dart';

const keyStyle = TextStyle(
  fontSize: 30,
  color: Colors.white,
);

const keyMap = [
  Text(
    "0",
    style: keyStyle,
  ),
  Text(
    "1",
    style: keyStyle,
  ),
  Text(
    "2",
    style: keyStyle,
  ),
  Text(
    "3",
    style: keyStyle,
  ),
  Text(
    "4",
    style: keyStyle,
  ),
  Text(
    "5",
    style: keyStyle,
  ),
  Text(
    "6",
    style: keyStyle,
  ),
  Text(
    "7",
    style: keyStyle,
  ),
  Text(
    "8",
    style: keyStyle,
  ),
  Text(
    "9",
    style: keyStyle,
  ),
  Text(
    ".",
    style: keyStyle,
  ),
  Icon(
    Icons.backspace,
    color: Colors.white,
  ),
  Icon(
    Icons.subdirectory_arrow_right,
    color: Colors.white,
  ),
];

class CalculatorKey extends StatelessWidget {
  final int symbol;
  final color = BACKGROUND_COLOR;
  final Function buttonTap;

  CalculatorKey({
    this.symbol,
    this.buttonTap,
  });

  @override
  Widget build(BuildContext context) {
    double size = 70;

    return Container(
        width: size,
        padding: EdgeInsets.all(2),
        height: symbol > 10 ? size * 2 : size,
        child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          color: color,
          elevation: 4,
          child: keyMap[symbol],
          onPressed: () => buttonTap(symbol.toString()),
        ));
  }
}

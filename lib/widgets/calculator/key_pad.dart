import 'package:flutter/widgets.dart';
import 'calculator_key.dart';

class KeyPad extends StatelessWidget {
  final Function buttonTap;

  KeyPad(this.buttonTap);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(children: <Widget>[
        CalculatorKey(symbol: 1, buttonTap: buttonTap),
        CalculatorKey(symbol: 4, buttonTap: buttonTap),
        CalculatorKey(symbol: 7, buttonTap: buttonTap),
        CalculatorKey(symbol: 10, buttonTap: buttonTap),
      ]),
      Column(children: <Widget>[
        CalculatorKey(symbol: 2, buttonTap: buttonTap),
        CalculatorKey(symbol: 5, buttonTap: buttonTap),
        CalculatorKey(symbol: 8, buttonTap: buttonTap),
        CalculatorKey(symbol: 0, buttonTap: buttonTap),
      ]),
      Column(children: <Widget>[
        CalculatorKey(symbol: 3, buttonTap: buttonTap),
        CalculatorKey(symbol: 6, buttonTap: buttonTap),
        CalculatorKey(symbol: 9, buttonTap: buttonTap),
        CalculatorKey(symbol: 10, buttonTap: buttonTap),
      ]),
      Column(children: <Widget>[
        CalculatorKey(symbol: 11, buttonTap: buttonTap),
        CalculatorKey(symbol: 12, buttonTap: buttonTap),
      ]),
    ]);
  }
}

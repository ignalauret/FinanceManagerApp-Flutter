import 'package:financemanager/utils/constants.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatelessWidget {
  final Function buildMenuButton;

  CalculatorScreen(this.buildMenuButton);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text(
          "Calculadora",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        leading: buildMenuButton(),
        backgroundColor: BACKGROUND_COLOR,
        elevation: 4,
      ),
      body: Center(
        child: Text(
          "Calculadora Financiera",
          style: TextStyle(
            color: TEXT_COLOR,
          ),
        ),
      ),
    );
  }
}

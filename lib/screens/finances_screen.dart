import 'package:financemanager/utils/constants.dart';
import 'package:flutter/material.dart';

class FinancesScreen extends StatelessWidget {
  final Function buildMenuButton;

  FinancesScreen(this.buildMenuButton);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text(
          "Finanzas",
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
          "Mis finanzas",
          style: TextStyle(
            color: TEXT_COLOR,
          ),
        ),
      ),
    );
  }
}

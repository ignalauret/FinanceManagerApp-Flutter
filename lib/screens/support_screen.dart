import 'package:financemanager/utils/constants.dart';
import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  final Function buildMenuButton;

  SupportScreen(this.buildMenuButton);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text(
          "Soporte",
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
          "Contacto a Soporte",
          style: TextStyle(
            color: TEXT_COLOR,
          ),
        ),
      ),
    );
  }
}

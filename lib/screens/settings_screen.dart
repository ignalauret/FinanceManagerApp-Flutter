import 'package:financemanager/utils/constants.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function buildMenuButton;

  SettingsScreen(this.buildMenuButton);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text(
          "Configuración",
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
          "Configuracion de la app",
          style: TextStyle(
            color: TEXT_COLOR,
          ),
        ),
      ),
    );
  }
}

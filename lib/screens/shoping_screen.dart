import 'package:financemanager/utils/constants.dart';
import 'package:flutter/material.dart';

class ShoppingScreen extends StatelessWidget {
  final Function buildMenuButton;

  ShoppingScreen(this.buildMenuButton);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        title: Text(
          "Lista de Compras",
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
          "Lista de compras en supermercado",
          style: TextStyle(
            color: TEXT_COLOR,
          ),
        ),
      ),
    );
  }
}

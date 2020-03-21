import 'package:flutter/material.dart';

class Wallet {
  final String id;
  final String name;
  double startingBalance;
  final Color color;

  Wallet(
      {@required this.id,
      @required this.name,
      this.color = Colors.amber,
      this.startingBalance = 0});

}

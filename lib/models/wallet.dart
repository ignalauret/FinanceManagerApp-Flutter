import 'package:financemanager/utils/constants.dart';
import 'package:flutter/material.dart';

class Wallet {
  final int id;
  final String name;
  double startingBalance;
  final Color color;

  Wallet({
    this.id,
    @required this.name,
    this.color = Colors.amber,
    this.startingBalance = 0,
  });

  Wallet.fromJson(dynamic obj)
      : this.id = obj["wid"],
        this.name = obj["name"],
        this.color = COLOR_PALETTE[obj["color"]],
        this.startingBalance = obj["startingbalance"];
}

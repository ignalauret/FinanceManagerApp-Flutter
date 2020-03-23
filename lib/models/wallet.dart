import 'package:flutter/material.dart';

class Wallet {
  final String id;
  final String name;
  double startingBalance;
  final Color color;

  Wallet({
    @required this.id,
    @required this.name,
    this.color = Colors.amber,
    this.startingBalance = 0,
  });

  Wallet.fromJson(dynamic obj)
      : this.id = obj["id"],
        this.name = obj["name"],
        this.color = Colors.amber;

  Map<String, dynamic> toJson() => {"name": name, "id": id};
}

//import 'package:financemanager/models/wallet.dart';
//import 'package:flutter/material.dart';
//
//class WalletsProvider with ChangeNotifier {
//  List<Wallet> _wallets = [
//    Wallet(
//      id: "0",
//      name: "Wallet 1",
//      color: Colors.blue,
//      startingBalance: 50,
//    ),
//    Wallet(
//      id: "1",
//      name: "Wallet 2",
//      color: Colors.red,
//    ),
//    Wallet(
//      id: "2",
//      name: "Wallet 3",
//      color: Colors.blue,
//      startingBalance: 50,
//    ),
//    Wallet(
//      id: "3",
//      name: "Wallet 4",
//      color: Colors.red,
//    ),
//    Wallet(
//      id: "4",
//      name: "Wallet 5",
//      color: Colors.blue,
//      startingBalance: 50,
//    ),
//  ];
//
//  // Getters
//  List<Wallet> get wallets {
//    return [..._wallets];
//  }
////
////  double get globalBalance {
////    double balance = 0.0;
////    _wallets.forEach((wal) => balance += wal.totalBalance);
////    return balance;
////  }
////
////  double get globalIncomesBalance {
////    double balance = 0.0;
////    _wallets.forEach((wal) => balance += wal.totalIncome);
////    return balance;
////  }
////
////  double get globalExpensesBalance {
////    double balance = 0.0;
////    _wallets.forEach((wal) => balance += wal.totalExpenses);
////    return balance;
////  }
//
//  // Querys
//
//  Wallet findById(String id) {
//    return _wallets.firstWhere((wal) => wal.id == id);
//  }
//
//  // Add and Delete
//  String get _newId {
//    return (int.parse(_wallets.last.id) + 1).toString();
//  }
//
//  void addWallet(
//      {@required String name,
//      Color color = Colors.amber,
//      double initialBalance = 0}) {
//    final newWallet = Wallet(
//      name: name,
//      color: color,
//      startingBalance: initialBalance,
//      id: _newId,
//    );
//    _wallets.add(newWallet);
//    notifyListeners();
//  }
//
//  void deleteWallet(String id) {
//    _wallets.removeWhere((wal) => wal.id == id);
//    notifyListeners();
//  }
//}

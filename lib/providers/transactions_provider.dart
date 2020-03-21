//import 'package:financemanager/models/transaction.dart';
//import 'package:financemanager/utils/tools.dart';
//import 'package:flutter/material.dart';
//
//class TransactionsProvider with ChangeNotifier {
//  List<Transaction> _transactions = [
//    Transaction(
//        id: "0",
//        amount: 250.00,
//        date: DateTime.now(),
//        note: "Nueva raqueta",
//        category: TransactionCategories.Compras,
//        isExpense: true,
//        walletId: "0"),
//    Transaction(
//        id: "1",
//        amount: 155.20,
//        date: DateTime.now(),
//        note: "Nueva raqueta",
//        category: TransactionCategories.Compras,
//        isExpense: true,
//        walletId: "0"),
//    Transaction(
//        id: "2",
//        amount: 53.30,
//        date: DateTime.now(),
//        note: "Nueva raqueta",
//        category: TransactionCategories.Compras,
//        isExpense: true,
//        walletId: "1"),
//  ];
//
//  /* ************* Getters *************** */
//  List<Transaction> get transactions {
//    return [..._transactions];
//  }
//
//  // Get transactions from last 7 days.
//  List<Transaction> get recentTransactions {
//    var recentTransactions = _transactions
//        .where(
//          (tran) => tran.date.isAfter(
//            DateTime.now().subtract(
//              Duration(days: 7),
//            ),
//          ),
//        )
//        .toList();
//    recentTransactions.sort((tran1, tran2) {return tran2.date.compareTo(tran1.date);});
//    return recentTransactions;
//  }
//
//  /* ************** Queries *************** */
//  List<Transaction> findByDate(DateTime date) {
//    return _transactions.where((tran) => isSameDay(tran.date, date)).toList();
//  }
//
//  double get globalIncomes {
//    double total = 0;
//    _transactions
//        .forEach((tran) => {if (!tran.isExpense) total += tran.amount});
//    return total;
//  }
//
//  double get globalExpenses {
//    double total = 0;
//    _transactions
//        .forEach((tran) => {if (tran.isExpense) total += tran.amount});
//    return total;
//  }
//
//  double get globalBalance {
//    return globalIncomes - globalExpenses;
//  }
//
//  /* ************** DB methods ************** */
//  String get _newId {
//    return (int.parse(_transactions.last.id) + 1).toString();
//  }
//
//  void deleteTransaction(String id) {
//    _transactions.removeWhere((tran) => tran.id == id);
//    notifyListeners();
//    print(_transactions);
//  }
//
//  void addTransaction(
//      {String note,
//      double amount,
//      DateTime date,
//      TransactionCategories category,
//      String walletId,
//      bool isExpense}) {
//    final newTransaction = Transaction(
//      note: note,
//      amount: amount,
//      date: date,
//      category: category,
//      walletId: walletId,
//      isExpense: isExpense,
//      id: _newId,
//    );
//    _transactions.add(newTransaction);
//    notifyListeners();
//  }
//}

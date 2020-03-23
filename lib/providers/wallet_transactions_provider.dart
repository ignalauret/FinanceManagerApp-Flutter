import 'package:financemanager/Database/db_helper.dart';
import 'package:financemanager/models/transaction.dart';
import 'package:financemanager/models/wallet.dart';
import 'package:financemanager/utils/tools.dart';
import 'package:flutter/material.dart';

class TransactionsWalletsProvider with ChangeNotifier {
  List<Transaction> _transactions = [
    Transaction(
        id: "0",
        amount: 250.00,
        date: DateTime.now(),
        note: "Nueva raqueta",
        category: TransactionCategories.Compras,
        isExpense: true,
        walletId: "0"),
    Transaction(
        id: "1",
        amount: 155.20,
        date: DateTime.now(),
        note: "Nueva raqueta",
        category: TransactionCategories.Compras,
        isExpense: true,
        walletId: "0"),
    Transaction(
        id: "2",
        amount: 53.30,
        date: DateTime.now(),
        note: "Nueva raqueta",
        category: TransactionCategories.Compras,
        isExpense: true,
        walletId: "1"),
  ];

  List<Wallet> wallets = [];
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
  //];

  /* ************* Getters *************** */
  List<Transaction> get transactions {
    return [..._transactions];
  }

  // Get transactions from last 7 days.
  List<Transaction> get recentTransactions {
    var recentTransactions = _transactions
        .where(
          (tran) => tran.date.isAfter(
            DateTime.now().subtract(
              Duration(days: 7),
            ),
          ),
        )
        .toList();
    recentTransactions.sort((tran1, tran2) {
      return tran2.date.compareTo(tran1.date);
    });
    return recentTransactions;
  }

//  List<Wallet> get wallets {
//    return [..._wallets];
//  }

  /* ************** Queries *************** */
  List<Transaction> findTransactionByDate(DateTime date) {
    return _transactions.where((tran) => isSameDay(tran.date, date)).toList();
  }

  Wallet findWalletById(String id) {
    return wallets.firstWhere((wal) => wal.id == id);
  }

  double get globalIncomes {
    double total = 0;
    _transactions
        .forEach((tran) => {if (!tran.isExpense) total += tran.amount});
    return total;
  }

  double get globalExpenses {
    double total = 0;
    _transactions.forEach((tran) => {if (tran.isExpense) total += tran.amount});
    return total;
  }

  double get globalBalance {
    double total = globalIncomes - globalExpenses;
    wallets.forEach((wal) => total += wal.startingBalance);
    return total;
  }

  double getGlobalBalanceOf(String walletId) {
    double total = findWalletById(walletId).startingBalance;
    _transactions.forEach((tran) => {
          if (tran.walletId == walletId)
            {tran.isExpense ? total -= tran.amount : total += tran.amount}
        });
    return total;
  }

  /* ********** DB Methods *************** */
  String get _newTransactionId {
    return (int.parse(_transactions.last.id) + 1).toString();
  }

  String get _newWalletId {
    return (int.parse(wallets.last.id) + 1).toString();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((tran) => tran.id == id);
    notifyListeners();
  }

  void addTransaction(
      {String note,
        double amount,
        DateTime date,
        TransactionCategories category,
        String walletId,
        bool isExpense}) {
    final newTransaction = Transaction(
      note: note,
      amount: amount,
      date: date,
      category: category,
      walletId: walletId,
      isExpense: isExpense,
      id: _newTransactionId,
    );
    _transactions.add(newTransaction);
    notifyListeners();
  }

  void addWallet(
      {@required String name,
        Color color = Colors.amber,
        double initialBalance = 0}) {
    final newWallet = Wallet(
      name: name,
      color: color,
      startingBalance: initialBalance,
      id: _newWalletId,
    );
    wallets.add(newWallet);
    notifyListeners();
  }

  void deleteWallet(String id) {
    wallets.removeWhere((wal) => wal.id == id);
    notifyListeners();
  }
}

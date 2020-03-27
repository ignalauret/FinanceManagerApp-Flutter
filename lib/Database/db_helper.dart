import 'dart:async';

import 'package:financemanager/models/transaction.dart' as tran;
import 'package:financemanager/models/wallet.dart';
import 'package:financemanager/utils/constants.dart';
import 'package:financemanager/utils/tools.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _dbInstance;

  /* *************** Database creation *************** */
  Future<Database> get db async {
    if (_dbInstance == null) _dbInstance = await initDB();
    return _dbInstance;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'finance_manager_db25.db');
    var db = await openDatabase(path, version: 1, onCreate: onCreateFunc);
    return db;
  }

  void onCreateFunc(Database db, int version) async {
    // create table
    await db.execute(
      'CREATE TABLE wallet(wid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, startingbalance REAL, color INTEGER);',
    );
    await db.execute(
      'CREATE TABLE tran(tid INTEGER PRIMARY KEY AUTOINCREMENT, note TEXT, amount REAL, category INTEGER, walletid INTEGER, isexpense INTEGER, date INTEGER);',
    );
  }

  /* ***************** CRUD Functions ******************* */

  // Get all wallets
  Future<List<Wallet>> getWallets() async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM wallet');
    List<Wallet> wallets = new List();
    for (int i = 0; i < list.length; i++) {
      Wallet wallet = new Wallet.fromJson(list[i]);

      wallets.add(wallet);
    }
    return wallets;
  }

  // Get all Transactions
  Future<List<tran.Transaction>> getTransactions() async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM tran');
    List<tran.Transaction> transactions = new List();
    for (int i = 0; i < list.length; i++) {
      tran.Transaction transaction = tran.Transaction.fromJson(list[i]);
      transactions.add(transaction);
    }
    return transactions;
  }

  // Delete wallet
  Future<int> deleteWallet(int id) async {
    return (await db).delete('wallet', where: 'wid = ?', whereArgs: [id]);
  }

  // Delete transaction
  Future<int> deleteTransaction(int id) async {
    return (await db).delete('tran', where: 'tid = ?', whereArgs: [id]);
  }

  // add new person
  void addNewWallet(Wallet wallet) async {
    var dbConnection = await db;
    int color = COLOR_PALETTE.indexOf(wallet.color);
    String query = """
        INSERT INTO wallet(name, startingbalance, color) VALUES('${wallet.name}', '${wallet.startingBalance}', '$color')
        """;
    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  void addNewTransaction(tran.Transaction trans) async {
    var dbConnection = await db;
    String query = """
        INSERT INTO tran(note, amount, category, walletid, isexpense, date) VALUES('${trans.note}','${trans.amount}','${tran.TransactionCategoryList.indexOf(trans.category)}','${trans.walletId}','${trans.isExpense ? 1 : 0}','${dateToInt(trans.date)}')
        """;
    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  /* ********* Queries *********** */

// Get transactions from last week
  Future<List<tran.Transaction>> getRecentTransactions() async {
    var dbConnection = await db;
    final date = dateToInt(DateTime.now().subtract(Duration(days: 7)));
    List<Map> list = await dbConnection.query('tran', where: 'date > $date');
    List<tran.Transaction> transactions = new List();
    for (int i = 0; i < list.length; i++) {
      tran.Transaction transaction = tran.Transaction.fromJson(list[i]);
      transactions.add(transaction);
    }
    return transactions;
  }

  Future<Map<int, List<tran.Transaction>>> getTransactionDayBlocks() async {
    // Get dates and make diff and sort them.
    List<int> dates = await getDates();
    dates = dates.toSet().toList();
    dates.sort((d1, d2) {
      return d2 - d1;
    });

    List<MapEntry<int, List<tran.Transaction>>> entries = [];
    for (int date in dates) {
      var entry = MapEntry(date, await getTransactionsOfDate(date));
      entries.add(entry);
    }
    print("Entries: $entries");

    Map<int, List<tran.Transaction>> result = {};
    result.addEntries(entries);
    return result;
  }

  Future<List<int>> getDates() async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.query('tran', columns: ['date']);
    List<int> dates = new List();
    for (int i = 0; i < list.length; i++) {
      int date = list[i]['date'];
      dates.add(date);
    }
    return dates;
  }

  Future<List<tran.Transaction>> getTransactionsOfDate(int date) async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.query('tran', where: 'date = $date');
    List<tran.Transaction> transactions = new List();
    for (int i = 0; i < list.length; i++) {
      tran.Transaction transaction = tran.Transaction.fromJson(list[i]);
      transactions.add(transaction);
    }
    return transactions;
  }

  // Get total income from transactions
  Future<double> getTotalIncome() async {
    var dbConnection = await db;
    var sum = await dbConnection
        .rawQuery('SELECT SUM(amount) AS result FROM tran WHERE isexpense = 0');
    print("Income sum: $sum");

    if (sum[0]["result"] == null)
      return 0;
    return sum[0]['result'];
  }

  // Get total expenses from transactions
  Future<double> getTotalExpense() async {
    var dbConnection = await db;
    var sum = await dbConnection
        .rawQuery('SELECT SUM(amount) AS result FROM tran WHERE isexpense = 1');
    print("Expense sum: $sum");
    if (sum[0]["result"] == null)
      return 0;
    return sum[0]['result'];
  }

  // Get total balance of account
  Future<double> getTotalBalance() async {
    var dbConnection = await db;
    var startingBalances = await dbConnection
        .rawQuery("SELECT SUM(startingbalance) AS result FROM wallet");

    var totalIncome = await getTotalIncome();
    var totalExpense = await getTotalExpense();
    print("Income: $totalIncome , Expense: $totalExpense");
    return totalIncome - totalExpense + startingBalances[0]["result"];
  }

  Future<double> getBalanceOfWallet(int walletId) async {
    var dbConnection = await db;
    var startingBalances = await dbConnection.rawQuery(
        "SELECT SUM(startingbalance) AS result FROM wallet WHERE wid = $walletId");

    var expenses = await dbConnection.rawQuery(
        "SELECT SUM(amount) AS result FROM tran WHERE walletid = $walletId AND isexpense = 1");
    if (expenses[0]["result"] == null)
      expenses = [
        {"result": 0}
      ];

    var incomes = await dbConnection.rawQuery(
        "SELECT SUM(amount) AS result FROM tran WHERE walletid = $walletId AND isexpense = 0");
    if (incomes[0]["result"] == null)
      incomes = [
        {"result": 0}
      ];
    return startingBalances[0]["result"] +
        incomes[0]["result"] -
        expenses[0]["result"];
  }
}

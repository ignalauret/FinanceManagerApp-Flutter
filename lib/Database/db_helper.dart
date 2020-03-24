import 'dart:async';

import 'package:financemanager/models/transaction.dart' as tran;
import 'package:financemanager/models/wallet.dart';
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
    String path = join(databasesPath, 'finance_manager_db5.db');
    var db = await openDatabase(path, version: 1, onCreate: onCreateFunc);
    return db;
  }

  void onCreateFunc(Database db, int version) async {
    // create table
    await db
        .execute('CREATE TABLE wallet(wid INTEGER PRIMARY KEY, name TEXT);');
    await db.execute(
        'CREATE TABLE tran(tid INTEGER PRIMARY KEY, note TEXT, amount REAL, category INTEGER, walletid INTEGER, isexpense INTEGER, date TEXT);');
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

  // Get recent transactions
  Future<List<tran.Transaction>> getRecentTransactions() async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM tran');
    List<tran.Transaction> transactions = new List();
    for (int i = 0; i < list.length; i++) {
      tran.Transaction transaction = tran.Transaction.fromJson(list[i]);
      transactions.add(transaction);
    }
    return transactions;
  }

  // add new person
  void addNewWallet(Wallet wallet) async {
    var dbConnection = await db;
    String query = """
        INSERT INTO wallet(wid, name) VALUES('${wallet.id}','${wallet.name}')
        """;
    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  void addNewTransaction(tran.Transaction trans) async {
    var dbConnection = await db;
    String query = """
        INSERT INTO tran(tid, note, amount, category, walletid, isexpense, date) VALUES('${trans.id}','${trans.note}','${trans.amount}','${tran.TransactionCategoryList.indexOf(trans.category)}','${trans.walletId}','${trans.isExpense ? 1 : 0}','${trans.date.toIso8601String()}')""";
    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }
}

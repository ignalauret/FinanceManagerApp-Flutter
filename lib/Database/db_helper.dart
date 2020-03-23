import 'dart:async';

import 'package:financemanager/models/wallet.dart';
import 'package:financemanager/providers/wallet_transactions_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db
        .execute("CREATE TABLE billeteras(id TEXT PRIMARY KEY, nombre TEXT)");
    print("Tabla creada");
  }

  Future<int> saveWallet(Wallet wallet) async {
    var dbClient = await db;
    int res = await dbClient.insert("billeteras", wallet.toJson());
    print("Tabla billetera insertada");
    return res;
  }

  Future<List<Wallet>> getWallets() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery("SELECT * FROM billeteras");
    List<Wallet> wallets = List();
    for (int i = 0; i < list.length; i++) {
      wallets.add(Wallet(
        id: list[i]["id"],
        name: list[i]["name"],
      ));
    }
    print(wallets.length);
    return wallets;
  }
}

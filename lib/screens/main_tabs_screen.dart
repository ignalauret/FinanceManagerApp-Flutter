import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:financemanager/Database/db_helper.dart';
import 'package:financemanager/models/transaction.dart';
import 'package:financemanager/models/wallet.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/modalSheets/new_transaction_sheet.dart';
import '../widgets/modalSheets/new_wallet_sheet.dart';
import 'home_tab.dart';
import 'transactions_tab.dart';
import 'wallets_tab.dart';

class MainTabsScreen extends StatefulWidget {
  final Function buildMenuButton;

  MainTabsScreen(this.buildMenuButton);
  @override
  _MainTabsScreenState createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _tabIndex = 0;

  /* ******* DB managmenet ******** */
  @override
  void initState() {
    super.initState();
    //loadDB();
  }

  void loadDB() async {
    final dbHelper = DBHelper();
    final wallet = Wallet(
        name: "TestDB",
        color: CATEGORY_TRANSPORTATION_COLOR,
        startingBalance: 50);
    final wallet1 = Wallet(name: "TestDB1", color: CATEGORY_SALARY_COLOR);
    final wallet2 = Wallet(name: "TestDB2", color: CATEGORY_MEDICAL_COLOR);
    dbHelper.addNewWallet(wallet);
    dbHelper.addNewWallet(wallet1);
    dbHelper.addNewWallet(wallet2);
    final tran1 = Transaction(
        id: 3,
        amount: 45.20,
        date: DateTime.now().subtract(Duration(days: 10)),
        note: "Test DB",
        category: TransactionCategories.Transporte,
        walletId: 1,
        isExpense: false);
    final tran2 = Transaction(
        id: 2,
        amount: 245.20,
        date: DateTime.now(),
        note: "Test DB2",
        category: TransactionCategories.Salario,
        walletId: 2,
        isExpense: true);
    dbHelper.addNewTransaction(tran1);
    dbHelper.addNewTransaction(tran2);
  }

  /* ***** Events ******** */
  void startAddNewExpense(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransactionSheet(true);
        }).then((_) {
      setState(() {
        _tabIndex = _tabIndex * 1;
      });
    });
  }

  void startAddNewIncome(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransactionSheet(false);
        }).then((_) {
      setState(() {
        _tabIndex = _tabIndex * 1;
      });
    });
  }

  void startAddNewWallet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewWalletSheet();
        }).then((_) {
      setState(() {
        _tabIndex = _tabIndex * 1;
      });
    });
  }

  /* ****** Build Methods ***** */
  Widget _buildAppBarTitle() {
    switch (_tabIndex) {
      case 0:
        return Text(
          "Home",
          style: TextStyle(
            color: Colors.grey,
          ),
        );
      case 1:
        return Text(
          "Transacciones",
          style: TextStyle(
            color: Colors.grey,
          ),
        );
      case 2:
        return Text(
          "Estadísticas",
          style: TextStyle(
            color: Colors.grey,
          ),
        );
      case 3:
        return Text(
          "Billeteras",
          style: TextStyle(
            color: Colors.grey,
          ),
        );
    }
    return null;
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: _buildAppBarTitle(),
      backgroundColor: BACKGROUND_COLOR,
      elevation: 4,
      leading: widget.buildMenuButton(),
      actions: <Widget>[
        if (_tabIndex == 1)
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              startAddNewExpense(context);
            },
          ),
        if (_tabIndex <= 2)
          PopupMenuButton<String>(
            icon: Icon(Icons.add),
            color: CARDS_COLOR,
            onSelected: (val) {
              if (val == "Income")
                startAddNewIncome(context);
              else
                startAddNewExpense(context);
            },
            itemBuilder: (ctx) {
              return [
                PopupMenuItem<String>(
                  value: "Income",
                  child: Text(
                    "Ingreso",
                    style: MENU_TEXT_STYLE,
                  ),
                ),
                PopupMenuItem<String>(
                  value: "Gasto",
                  child: Text(
                    "Gasto",
                    style: MENU_TEXT_STYLE,
                  ),
                ),
                PopupMenuItem<String>(
                  value: "Transferencia",
                  child: Text(
                    "Transferencia",
                    style: MENU_TEXT_STYLE,
                  ),
                ),
              ];
            },
          ),
        if (_tabIndex == 3)
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              startAddNewWallet(context);
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      HomeScreen(),
      TransactionsScreen(),
      HomeScreen(),
      WalletsScreen(),
    ];



    return Scaffold(
            backgroundColor: BACKGROUND_COLOR,
            appBar: _buildAppBar(context),
            body: Container(
              margin: EdgeInsets.only(bottom: 0),
              child: tabs[_tabIndex],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: BACKGROUND_COLOR,
              animationDuration: Duration(milliseconds: 200),
              color: CARDS_COLOR,
              index: _tabIndex,
              height: 50,
              items: <Widget>[
                Icon(
                  Icons.home,
                  size: 25,
                  color: Colors.white,
                ),
                Icon(
                  Icons.compare_arrows,
                  size: 25,
                  color: Colors.white,
                ),
                Icon(
                  Icons.list,
                  size: 25,
                  color: Colors.white,
                ),
                Icon(
                  Icons.account_balance_wallet,
                  size: 25,
                  color: Colors.white,
                ),
              ],
              onTap: (index) {
                setState(() {
                  _tabIndex = index;
                });
              },
            ),
          );
  }
}

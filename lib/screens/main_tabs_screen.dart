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

  /* ***** Events ******** */
  void startAddNewExpense(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransactionSheet(true);
        }).then((_) {
      rebuild();
    });
  }

  void startAddNewIncome(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransactionSheet(false);
        }).then((_) {});
  }

  void startAddNewWallet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewWalletSheet();
        }).then((_) {
      rebuild();
    });
  }

  /* ****** Build Methods ***** */
  void rebuild() {
    setState(() {
      _tabIndex = _tabIndex * 1;
    });
  }

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

  void loadDB() async {
    final wallets = await DBHelper().getWallets();
    if (wallets.length == 0)
      DBHelper().addNewWallet(
          Wallet(name: "Billetera", color: CATEGORY_TRANSPORTATION_COLOR)).then((_) => rebuild());
  }

  Widget _buildAppBar(BuildContext context) {
    loadDB();
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
      TransactionsScreen(rebuild),
      HomeScreen(),
      WalletsScreen(rebuild),
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

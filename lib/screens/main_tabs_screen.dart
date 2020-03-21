import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'transactions_screen.dart';
import 'wallets_screen.dart';
import '../widgets/modalSheets/new_transaction_sheet.dart';
import '../widgets/modalSheets/new_wallet_sheet.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'home_screen.dart';

class MainTabsScreen extends StatefulWidget {
  @override
  _MainTabsScreenState createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _tabIndex = 0;

  void startAddNewExpense(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransactionSheet(true);
        });
  }

  void startAddNewIncome(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransactionSheet(false);
        });
  }

  void startAddNewWallet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewWalletSheet();
        });
  }

  Widget _buildAppBarTitle() {
    switch(_tabIndex) {
      case 0 : return Text(
        "Home",
        style: TextStyle(
          color: Colors.grey,
        ),
      );
      case 1 : return Text(
        "Transacciones",
        style: TextStyle(
          color: Colors.grey,
        ),
      );
      case 2 : return Text(
        "Estadísticas",
        style: TextStyle(
          color: Colors.grey,
        ),
      );
      case 3 : return Text(
        "Billeteras",
        style: TextStyle(
          color: Colors.grey,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: _buildAppBarTitle(),
      backgroundColor: BACKGROUND_COLOR,
      elevation: 4,
      leading: IconButton(
        icon: Icon(
          Icons.menu,
        ),
        onPressed: () {},
      ),
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
//          IconButton(
//            icon: Icon(
//              Icons.add,
//            ),
//            onPressed: () {
//              startAddNewExpense(context);
//            },
//          ),
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

    final tabs = [
      HomeScreen(),
      TransactionsScreen(),
      HomeScreen(),
      WalletsScreen(),
    ];

    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: appBar,
      body: tabs[_tabIndex],
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

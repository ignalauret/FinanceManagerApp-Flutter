import 'package:flutter/material.dart';

import '../widgets/cards/total_balance_card.dart';
import '../widgets/transactionsList/transactions_list.dart';
import '../widgets/cards/balance_card.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TotalBalanceCard("35"),
        Row(
          children: <Widget>[
            Expanded(
              child: BalanceCard(
                title: "Ingresos",
                color: INCOME_COLOR,
                balance: 35,
              ),
            ),
            Expanded(
              child: BalanceCard(
                title: "Gastos",
                color: EXPENSE_COLOR,
                balance: 35,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
          child: Text(
            "Transacciones recientes",
            style: TITLE_STYLE,
          ),
        ),
        Expanded(
          child: TransactionsList(),
        ),
      ],
    );
  }
}

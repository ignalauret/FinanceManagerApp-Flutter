import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wallet_transactions_provider.dart';
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
    final providerData = Provider.of<TransactionsWalletsProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TotalBalanceCard(providerData.globalBalance.toStringAsFixed(2)),
        Row(
          children: <Widget>[
            Expanded(
              child: BalanceCard(
                title: "Ingresos",
                color: INCOME_COLOR,
                balance: providerData.globalIncomes,
              ),
            ),
            Expanded(
              child: BalanceCard(
                title: "Gastos",
                color: EXPENSE_COLOR,
                balance: providerData.globalExpenses,
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

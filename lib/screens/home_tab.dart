import 'package:financemanager/Database/db_helper.dart';
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
        FutureBuilder(
          future: DBHelper().getTotalBalance(),
          builder: (context, snapshot) {
            if (snapshot != null && snapshot.hasData) {
              return TotalBalanceCard(snapshot.data);
            }
            return new Container(
              alignment: AlignmentDirectional.center,
              child: new CircularProgressIndicator(),
            );
          },
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                future: DBHelper().getTotalIncome(),
                builder: (context, snapshot) {
                  if (snapshot != null && snapshot.hasData) {
                    return BalanceCard(
                      title: "Ingresos",
                      color: INCOME_COLOR,
                      balance: snapshot.data,
                    );
                  }
                  return new Container(
                    alignment: AlignmentDirectional.center,
                    child: new CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: DBHelper().getTotalExpense(),
                builder: (context, snapshot) {
                  if (snapshot != null && snapshot.hasData) {
                    return BalanceCard(
                      title: "Gastos",
                      color: EXPENSE_COLOR,
                      balance: snapshot.data,
                    );
                  }
                  return new Container(
                    alignment: AlignmentDirectional.center,
                    child: new CircularProgressIndicator(),
                  );
                },
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

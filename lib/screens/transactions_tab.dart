import 'package:financemanager/Database/db_helper.dart';
import 'package:financemanager/models/transaction.dart';
import 'package:financemanager/utils/tools.dart';
import 'package:flutter/material.dart';

import '../widgets/cards/transactions_block_card.dart';

class TransactionsScreen extends StatelessWidget {
  final Function rebuild;
  TransactionsScreen(this.rebuild);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: FutureBuilder<Map<int, List<Transaction>>>(
                future: DBHelper().getTransactionDayBlocks(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (ctx, index) {
                          var date = intToDate(snapshot.data.keys.toList()[index]);
                          var list = snapshot.data.values.toList()[index];
                          return TransactionsBlockCard(date, list, rebuild);
                        },
                        itemCount: snapshot.data.length,
                      );
                    }
                  }
                  return new Container(
                    alignment: AlignmentDirectional.center,
                    child: new CircularProgressIndicator(),
                  );
                })),
      ],
    );
  }
}

import 'package:financemanager/Database/db_helper.dart';
import 'package:financemanager/models/transaction.dart';
import 'package:financemanager/widgets/transactionsList/transactions_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/cards/transactions_block_card.dart';

class TransactionsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
            child: FutureBuilder<List<Transaction>>(
                future: DBHelper().getTransactions(),
                builder: (context, snapshot) {
                  print(snapshot.data);

                  if (snapshot.data != null) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (ctx, index) {
                          return TransactionListItem(
                              snapshot.data[index], true);
                        },
                        itemCount: snapshot
                            .data.length, //TODO: Saber hasta donde iterar
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

import 'transactions_list_item.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final transactionsData = Provider.of<TransactionsWalletsProvider>(context);
    final transactions = [];

    return Container(
      child: Container(
        child: (transactions.isEmpty)
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      "No recent transactions",
                    ),
                  ],
                );
              })
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(transactions[index].id),
                    onDismissed: (direction) {
                      //transactionsData.deleteTransaction(transactions[index].id);
                    },
                    child: TransactionListItem(transactions[index], true),
                  );
                },
              ),
      ),
    );
  }
}

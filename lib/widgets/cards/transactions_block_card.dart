import '../../models/transaction.dart';
import '../../utils/constants.dart';
import '../transactionsList/transactions_list_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsBlockCard extends StatelessWidget {
  final DateTime date;
  final List<Transaction> transactions;
  final Function rebuild;

  TransactionsBlockCard(this.date, this.transactions, this.rebuild);

  List<Widget> _buildExpenses() {
    List<Widget> list = [];
    for (int i = 0; i < transactions.length; i++) {
      list.add(TransactionListItem(transactions[i], false, rebuild));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Container(width: 0, height: 0,)
        : Card(
            color: BACKGROUND_COLOR,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3.0,
                    horizontal: 12,
                  ),
                  child: Text(
                    DateFormat("EEE d, MMMM").format(date),
                    style: TITLE_STYLE,
                  ),
                ),
                ..._buildExpenses(),
              ],
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';
import '../../utils/constants.dart';
import '../color_bar.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final bool withDate;

  TransactionListItem(this.transaction, this.withDate);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CARDS_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CARDS_BORDER_RADIUS),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 10,
      ),
      elevation: CARDS_ELEVATION,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                ColorBar(
                  color: TransactionCategoryColor[transaction.category],
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  transaction.note,
                  style: TextStyle(
                    color: TEXT_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 12),
            child: Row(
              children: <Widget>[
                FittedBox(
                  child: transaction.isExpense
                      ? Text(
                          "-\$${transaction.amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: EXPENSE_COLOR,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Text(
                          "+\$${transaction.amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: INCOME_COLOR,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
                if (withDate)
                  Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text(
                      DateFormat("d MMM").format(transaction.date),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

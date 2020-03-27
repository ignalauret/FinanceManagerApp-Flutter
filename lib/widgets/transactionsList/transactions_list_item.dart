import 'dart:math';

import 'package:financemanager/Database/db_helper.dart';
import 'package:financemanager/widgets/modalSheets/new_transaction_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../../models/transaction.dart';
import '../../utils/constants.dart';
import '../color_bar.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final bool withDate;
  final Function rebuild;

  TransactionListItem(this.transaction, this.withDate, this.rebuild);

  void deleteTransaction() {
    DBHelper().deleteTransaction(transaction.id);
  }

  void editTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransactionSheet.edit(transaction);
      },
    ).then((_) => rebuild());
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(Random().nextInt(10000).toString()),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart)
          deleteTransaction();
        else
          editTransaction(context);
      },
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.edit,
              color: TEXT_COLOR,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Editar",
              style: TextStyle(color: TEXT_COLOR, fontSize: 15),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "Borrar",
              style: TextStyle(color: DANGER_COLOR, fontSize: 15),
            ),
            SizedBox(
              width: 8,
            ),
            Icon(
              Icons.delete,
              color: DANGER_COLOR,
              size: 30,
            ),
          ],
        ),
      ),
      child: Card(
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
      ),
    );
  }
}

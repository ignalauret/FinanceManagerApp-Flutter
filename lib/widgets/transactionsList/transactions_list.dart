import 'package:financemanager/Database/db_helper.dart';

import 'transactions_list_item.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DBHelper().getRecentTransactions(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.hasData) {
              return Container(
                child: (snapshot.data.isEmpty)
                    ? Text(
                        "No recent transactions",
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return TransactionListItem(
                              snapshot.data[index], true);
                        },
                      ),
              );
            }
          }
          return new Container(
            alignment: AlignmentDirectional.center,
            child: new CircularProgressIndicator(),
          );
        });
  }
}

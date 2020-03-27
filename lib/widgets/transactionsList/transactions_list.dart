import 'package:financemanager/Database/db_helper.dart';
import 'package:financemanager/utils/constants.dart';
import 'package:flutter/rendering.dart';

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
                    ? Center(
                        child: Text(
                          "No hay transacctiones recientes. Agrega una con el botón +.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: TEXT_COLOR,
                            fontSize: 25,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return TransactionListItem(
                              snapshot.data[index], true, null);
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

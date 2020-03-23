import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/wallet_transactions_provider.dart';
import '../widgets/cards/transactions_block_card.dart';

class TransactionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Consumer<TransactionsWalletsProvider>(
            builder: (_, transactionsData, __) => ListView.builder(
              itemBuilder: (ctx, index) {
                final date = DateTime.now().subtract(Duration(days: index));
                return TransactionsBlockCard(date, transactionsData.findTransactionByDate(date));
              },
              itemCount: 100, //TODO: Saber hasta donde iterar
            ),
          ),
        )
      ],
    );
  }
}

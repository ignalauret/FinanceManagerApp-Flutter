import '../providers/wallet_transactions_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cards/balance_card.dart';

class WalletsDisplay extends StatelessWidget {
  final int selectedIndex;
  final Function selectWallet;

  WalletsDisplay(this.selectedIndex, this.selectWallet);

  @override
  Widget build(BuildContext context) {
    final walletsData = Provider.of<TransactionsWalletsProvider>(context);
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 2,
      ),
      itemBuilder: (ctx, index) {
        return GestureDetector(
          child: BalanceCard(
            title: walletsData.wallets[index].name,
            color: walletsData.wallets[index].color,
            balance:
                walletsData.getGlobalBalanceOf(walletsData.wallets[index].id),
            selected: index == selectedIndex,
            fixedHeight: false,
          ),
          onTap: () => selectWallet(index),
        );
      },
      itemCount: walletsData.wallets.length,
    );
  }
}

import 'package:financemanager/Database/db_helper.dart';
import 'package:financemanager/models/wallet.dart';
import 'package:financemanager/widgets/modalSheets/new_wallet_sheet.dart';

import 'package:flutter/material.dart';

import 'cards/balance_card.dart';

class WalletsDisplay extends StatelessWidget {
  final int selectedIndex;
  final Function selectWallet;
  final Function rebuild;

  WalletsDisplay(this.selectedIndex, this.selectWallet, this.rebuild);

  Future<Map> getWalletsWithBalances() async {
    var wallets = await DBHelper().getWallets();
    var balances = [];
    for (Wallet wal in wallets) {
      balances.add(await DBHelper().getBalanceOfWallet(wal.id));
    }
    return {"wallets": wallets, "balances": balances};
  }

  void startEditWallet(Wallet wallet, BuildContext ctx) {

      showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewWalletSheet.edit(wallet);
        },
      ).then((_) => rebuild());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<Map>(
            future: getWalletsWithBalances(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4 / 2,
                    ),
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        child: BalanceCard(
                          title: snapshot.data["wallets"][index].name,
                          color: snapshot.data["wallets"][index].color,
                          balance: snapshot.data["balances"][index],
                          selected: index == selectedIndex,
                          fixedHeight: false,
                        ),
                        onTap: () => selectWallet(index),
                        onLongPress: () => startEditWallet(snapshot.data["wallets"][index], context),
                      );
                    },
                    itemCount: snapshot.data["wallets"].length,
                  );
                }
              }
              return new Container(
                alignment: AlignmentDirectional.center,
                child: new CircularProgressIndicator(),
              );
            }));
  }
}
import 'package:financemanager/Database/db_helper.dart';
import 'package:financemanager/models/wallet.dart';

import 'package:flutter/material.dart';

import 'cards/balance_card.dart';

class WalletsDisplay extends StatelessWidget {
  final int selectedIndex;
  final Function selectWallet;

  WalletsDisplay(this.selectedIndex, this.selectWallet);

  Future<List<Wallet>> getWalletsFromDB() async {
    print("Get Wallets from DB Method");
    var dbHelper = DBHelper();
    Future<List<Wallet>> wallets = dbHelper.getWallets();
    return wallets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<List<Wallet>>(
            future: getWalletsFromDB(),
            builder: (context, snapshot) {
              print(snapshot.data);

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
                          title: snapshot.data[index].name,
                          color: snapshot.data[index].color,
                          balance: 35,
                          selected: index == selectedIndex,
                          fixedHeight: false,
                        ),
                        onTap: () => selectWallet(index),
                      );
                    },
                    itemCount: snapshot.data.length,
                  );
                }
              }
              return new Container(
                alignment: AlignmentDirectional.center,
                child: new CircularProgressIndicator(),
              );
            }));
  }

//  @override
//  Widget build(BuildContext context) {
//    final walletsData = Provider.of<TransactionsWalletsProvider>(context);
//    return GridView.builder(
//      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//        crossAxisCount: 2,
//        childAspectRatio: 4 / 2,
//      ),
//      itemBuilder: (ctx, index) {
//        return GestureDetector(
//          child: BalanceCard(
//            title: walletsData.wallets[index].name,
//            color: walletsData.wallets[index].color,
//            balance:
//                walletsData.getGlobalBalanceOf(walletsData.wallets[index].id),
//            selected: index == selectedIndex,
//            fixedHeight: false,
//          ),
//          onTap: () => selectWallet(index),
//        );
//      },
//      itemCount: walletsData.wallets.length,
//    );
//  }
}

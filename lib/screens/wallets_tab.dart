import 'package:financemanager/widgets/wallets_display.dart';
import 'package:flutter/material.dart';

class WalletsScreen extends StatefulWidget {
  final Function rebuild;
  WalletsScreen(this.rebuild);
  @override
  _WalletsScreenState createState() => _WalletsScreenState();
}

class _WalletsScreenState extends State<WalletsScreen> {
  int _selectedWalletIndex = 0;

  void _selectWallet(int index) {
    setState(() {
      _selectedWalletIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 500,
          width: double.infinity,
          child: WalletsDisplay(_selectedWalletIndex, _selectWallet, widget.rebuild),
        ),
      ],
    );
  }
}

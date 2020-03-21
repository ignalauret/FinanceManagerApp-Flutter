import 'providers/wallet_transactions_provider.dart';

import 'screens/main_tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: TransactionsWalletsProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          canvasColor: Colors.transparent,
          primarySwatch: Colors.blue,
        ),
        home: MainTabsScreen(),
      ),
    );
  }
}
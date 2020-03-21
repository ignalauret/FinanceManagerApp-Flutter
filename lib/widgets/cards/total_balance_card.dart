import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class TotalBalanceCard extends StatelessWidget {
  final String balance;

  TotalBalanceCard(this.balance);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                "Balance total",
                style: TITLE_STYLE,
              ),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "\$ ",
                    style: TextStyle(
                      color: Colors.yellow[800],
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: balance,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ]),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                "Semana pasada",
                style: TITLE_STYLE,
              ),
              Text(
                "+25%",
                style: TextStyle(
                  color: INCOME_COLOR,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

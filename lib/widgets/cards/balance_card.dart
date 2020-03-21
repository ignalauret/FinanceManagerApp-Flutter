import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../color_bar.dart';

class BalanceCard extends StatelessWidget {
  final String title;
  final Color color;
  final double balance;
  final bool selected;
  final bool fixedHeight;

  BalanceCard({
    this.title,
    this.color,
    this.balance,
    this.selected = true,
    this.fixedHeight = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CARDS_BORDER_RADIUS),
        side: selected
            ? BorderSide.none
            : BorderSide(width: 2.5, color: CARDS_COLOR),
      ),
      color: selected ? CARDS_COLOR : BACKGROUND_COLOR,
      margin: EdgeInsets.all(10),
      elevation: CARDS_ELEVATION,
      child: Row(
        children: <Widget>[
          ColorBar(
            color: color,
            height: 40,
            fixedHeight: fixedHeight,
          ),
          Expanded(
            child: Padding(
              padding:
              const EdgeInsets.only(left: 0, top: 8, right: 8, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        title,
                        style: TITLE_STYLE,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
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
                            text: balance.toStringAsFixed(2),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          )
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
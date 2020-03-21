import 'package:financemanager/utils/constants.dart';
import 'package:flutter/material.dart';

import '../color_bar.dart';

class DetailInputButton extends StatelessWidget {
  final String label;
  final Color color;
  final String value;
  final Function onPressedFun;

  DetailInputButton({
    this.color,
    this.label,
    this.onPressedFun,
    this.value,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressedFun,
      child: Card(
        color: BACKGROUND_COLOR,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CARDS_BORDER_RADIUS),
          side: BorderSide(
            color: CARDS_COLOR,
            width: 3,
          ),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 7,
          horizontal: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    ColorBar(
                      color: color,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        color: TEXT_COLOR,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
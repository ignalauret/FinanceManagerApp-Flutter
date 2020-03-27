import 'package:financemanager/utils/constants.dart';
import 'package:flutter/material.dart';

import '../color_bar.dart';

class ColorPickerInput extends StatelessWidget {
  final Function pickColor;
  final Color pickedColor;

  ColorPickerInput(this.pickColor, this.pickedColor);

  final Map<Color, ContainerWithColor> colors = Map.fromEntries(
    COLOR_PALETTE.map(
      (color) => MapEntry(
        color,
        ContainerWithColor(color, Key(color.toString())),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  ColorBar(
                    color: pickedColor,
                    height: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Color:",
                    style: TextStyle(
                      color: TEXT_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
            DropdownButton<ContainerWithColor>(
              items: colors.values.map((container) {
                var result = DropdownMenuItem<ContainerWithColor>(
                  child: container,
                  value: container,
                );
                return result;
              }).toList(),
              value: colors[pickedColor],
              onChanged: (val) {
                pickColor(val.color);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerWithColor extends StatelessWidget {
  final Color color;
  final Key key;

  ContainerWithColor(this.color, this.key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
      width: 60,
      height: 15,
    );
  }
}

import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import '../color_bar.dart';

class NoteInput extends StatelessWidget {
  final Function changeTitle;
  final String hint;
  NoteInput(this.changeTitle, this.hint);

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
                    color: Theme.of(context).primaryColor,
                    height: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      onChanged: (newVal) {
                        changeTitle(newVal);
                      },
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: TextStyle(
                          color: TEXT_COLOR,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import '../color_bar.dart';

class TextInput extends StatefulWidget {
  final Function changeTitle;
  final String hint;
  final String value;
  TextInput(this.changeTitle, this.hint, this.value);

  @override
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  TextEditingController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = TextEditingController(text: widget.value);
    super.initState();
  }

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
                      onSubmitted: (val) {
                        print("submitted: ${controller.text}");
                        widget.changeTitle(val);
                      },
                      controller: controller,
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: widget.hint,
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

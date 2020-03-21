import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import 'calculator_view.dart';
import 'key_pad.dart';

class CalculatorDialog extends StatefulWidget {
  final Function submit;
  CalculatorDialog(this.submit);

  @override
  _CalculatorDialogState createState() => _CalculatorDialogState();
}

class _CalculatorDialogState extends State<CalculatorDialog> {
  var actualValue = "";

  void changeValue(String newChar) {
    if (newChar == "10") {
      if (!actualValue.contains(".")) {
        setState(() {
          actualValue += ".";
        });
      }
    } else if (newChar == "11" && actualValue.length > 0) {
      setState(() {
        actualValue = actualValue.substring(0, actualValue.length - 1);
      });
    } else if (newChar == "12") {
      widget.submit(actualValue);
      Navigator.of(context).pop();
    } else {
      setState(() {
        actualValue += newChar;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: CARDS_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Container(
          height: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CalculatorView(actualValue),
              KeyPad(changeValue),
            ],
          ),
        ));
  }
}

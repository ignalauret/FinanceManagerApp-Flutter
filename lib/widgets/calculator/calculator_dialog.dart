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
    if (newChar == "11" && actualValue.length > 0) {
      // Delete char
      setState(() {
        actualValue = actualValue.substring(0, actualValue.length - 1);
      });
    } else if (newChar == "12") {
      // Submit data
      if (!actualValue.contains(".")) {
        actualValue += ".00";
      } else {
        if (actualValue[actualValue.length - 1] == ".") {
          // Delete "." at end of number
          actualValue = actualValue.substring(0, actualValue.length - 1);
          actualValue += ".00";
        } else if (actualValue[actualValue.length - 2] == ".")
          // Add 0 if just one decimal place
          actualValue += "0";
        else
          // Delete more than 2 decimal places
          actualValue = actualValue.substring(0, actualValue.indexOf(".") + 3);
      }
      widget.submit(actualValue);
      Navigator.of(context).pop();
    } else if (actualValue.length >= 8 || (actualValue.length >= 6 && !actualValue.contains(".")))
      // Do nothing if length to big
      return;
    else if (newChar == "10" && !actualValue.contains(".")) {
      // Add . if doesn't have one yet
      setState(() {
        actualValue += ".";
      });
    } else if (newChar == "0" && actualValue.length == 0)
      // Do nothing if first digit is a 0
      return;
    else
      // Add char if is a normal char
      setState(() {
        actualValue += newChar;
      });
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

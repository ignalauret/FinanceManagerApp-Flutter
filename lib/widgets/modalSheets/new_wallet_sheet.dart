import '../../utils/constants.dart';
import '../calculator/calculator_dialog.dart';
import '../userInput/detail_input_button.dart';
import '../userInput/text_input.dart';
import 'package:flutter/material.dart';

class NewWalletSheet extends StatefulWidget {
  @override
  _NewWalletSheetState createState() => _NewWalletSheetState();
}

class _NewWalletSheetState extends State<NewWalletSheet> {
  String _calculatorInput = "0";
  String _selectedNote = "";

//  void submitData(BuildContext ctx) {
//    final enteredNote = _selectedNote;
//    final enteredAmount = double.parse(_calculatorInput);
//    if (enteredNote.isEmpty) return;
//
//    Provider.of<TransactionsWalletsProvider>(context, listen: false).addWallet(
//      name: _selectedNote,
//      initialBalance: enteredAmount,
//    );
//
//    Navigator.of(context).pop();
//  }

  void _submitCalculatorDialog(String value) {
    setState(() {
      _calculatorInput = value;
    });
  }

  void _showCalculatorDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return CalculatorDialog(_submitCalculatorDialog);
        });
  }

  void _newNote(String note) {
    setState(() {
      _selectedNote = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: BACKGROUND_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        elevation: 0,
        child: Container(
          margin: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Ingrese los detalles",
                style: TITLE_STYLE,
              ),
              NoteInput(_newNote, "Nombre:"),
              DetailInputButton(
                label: "Saldo Inicial:",
                color: INCOME_COLOR,
                value: "\$$_calculatorInput",
                onPressedFun: () {
                  _showCalculatorDialog(context);
                },
              ),
              DetailInputButton(
                label: "Color:",
                color: Colors.grey,
                value: "Color",
                onPressedFun: () {
                  // Show color picker
                },
              ),
              InkWell(
                onTap: () => {},//submitData(context),
                child: Card(
                  margin: const EdgeInsets.all(10),
                  color: CARDS_COLOR,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(CARDS_BORDER_RADIUS),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 30,
                        ),
                        Text(
                          _selectedNote == ""
                              ? "Create New Wallet"
                              : "Create $_selectedNote",
                          style: TextStyle(
                            color: TEXT_COLOR,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

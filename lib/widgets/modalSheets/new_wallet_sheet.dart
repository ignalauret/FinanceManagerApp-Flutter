import 'package:financemanager/Database/db_helper.dart';
import 'package:financemanager/models/wallet.dart';
import 'package:financemanager/widgets/userInput/dropdown_input.dart';

import '../../utils/constants.dart';
import '../calculator/calculator_dialog.dart';
import '../userInput/detail_input_button.dart';
import '../userInput/text_input.dart';
import 'package:flutter/material.dart';

class NewWalletSheet extends StatefulWidget {
  final Wallet _walletToEdit;
  final bool editMode;

  NewWalletSheet()
      : _walletToEdit = null,
        editMode = false;
  NewWalletSheet.edit(this._walletToEdit) : editMode = true;
  @override
  _NewWalletSheetState createState() => _NewWalletSheetState();
}

class _NewWalletSheetState extends State<NewWalletSheet> {
  String _calculatorInput = "0";
  String _selectedNote = "";
  Color _selectedColor = CATEGORY_TRANSPORTATION_COLOR;
  bool editModeSetted = false;

  void setEditMode() {
    _calculatorInput = widget._walletToEdit.startingBalance.toStringAsFixed(2);
    _selectedNote = widget._walletToEdit.name;
    _selectedColor = widget._walletToEdit.color;
    editModeSetted = true;
  }

  void submitData(BuildContext ctx) {
    final enteredNote = _selectedNote;
    final enteredAmount = double.parse(_calculatorInput);
    if (enteredNote.isEmpty) return;

    Wallet wallet = Wallet(
      id: widget.editMode ? widget._walletToEdit.id : null,
      name: _selectedNote,
      startingBalance: enteredAmount,
      color: _selectedColor,
    );
    if (widget.editMode)
      DBHelper().editWallet(wallet).then((_) => Navigator.of(context).pop());
    else
      DBHelper().addNewWallet(wallet).then((_) => Navigator.of(context).pop());
  }

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

  void _pickColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!editModeSetted && widget.editMode) setEditMode();

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
              TextInput(_newNote, "Nombre:", _selectedNote),
              DetailInputButton(
                label: "Saldo Inicial:",
                color: INCOME_COLOR,
                value: "\$$_calculatorInput",
                onPressedFun: () {
                  _showCalculatorDialog(context);
                },
              ),
              ColorPickerInput(_pickColor, _selectedColor),
              InkWell(
                onTap: () => submitData(context),
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

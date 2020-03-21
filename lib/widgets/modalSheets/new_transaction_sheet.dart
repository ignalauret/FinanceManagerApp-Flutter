import '../../models/transaction.dart';
import '../../providers/wallet_transactions_provider.dart';
import '../../utils/constants.dart';
import '../calculator/calculator_dialog.dart';
import '../cards/category_selection_card.dart';
import '../color_bar.dart';
import '../userInput/detail_input_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../userInput/text_input.dart';

class NewTransactionSheet extends StatefulWidget {
  final bool isExpense;
  NewTransactionSheet(this.isExpense);
  @override
  _NewTransactionSheetState createState() => _NewTransactionSheetState();
}

class _NewTransactionSheetState extends State<NewTransactionSheet> {
  String _calculatorInput = "0";
  DateTime _selectedDate = DateTime.now();
  int selectedCategoryIndex = 0;
  String _selectedNote = "";
  String _selectedWalletId = "0";

  void submitData(BuildContext ctx, TransactionsWalletsProvider providerData) {
    final enteredNote = _selectedNote;
    final enteredAmount = double.parse(_calculatorInput);
    if (enteredNote.isEmpty || enteredAmount <= 0 || _selectedWalletId.isEmpty)
      return;

    providerData.addTransaction(
      note: enteredNote,
      amount: enteredAmount,
      date: _selectedDate,
      isExpense: widget.isExpense,
      walletId: _selectedWalletId,
      category: widget.isExpense
          ? expenseCategories[selectedCategoryIndex]
          : incomeCategories[selectedCategoryIndex],
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) return;
      setState(() {
        _selectedDate = date;
      });
    });
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

  void _selectCategory(int index) {
    setState(() {
      selectedCategoryIndex = index;
    });
  }

  void _newNote(String note) {
    setState(() {
      _selectedNote = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<TransactionsWalletsProvider>(context, listen: false);

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Seleccione una categoria",
                    style: TITLE_STYLE,
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: CARDS_COLOR,
                    ),
                    child: DropdownButton<String>(
                      style: MENU_TEXT_STYLE,
                      value: providerData.findWalletById(_selectedWalletId).id,
                      items: providerData.wallets
                          .map((wal) => DropdownMenuItem<String>(
                                value: wal.id,
                                child: Row(
                                  children: <Widget>[
                                    ColorBar(
                                      color: wal.color,
                                      fixedHeight: true,
                                      height: 20,
                                    ),
                                    Text(
                                      wal.name,
                                      style: MENU_TEXT_STYLE,
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (val) {
                        setState(() {
                          _selectedWalletId = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
                width: double.infinity,
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return CategorySelectorCard(
                        index,
                        index == selectedCategoryIndex,
                        _selectCategory,
                        widget.isExpense);
                  },
                  itemCount: widget.isExpense
                      ? expenseCategories.length
                      : incomeCategories.length,
                ),
              ),
              Text(
                "Ingrese los detalles",
                style: TITLE_STYLE,
              ),
              NoteInput(_newNote, "Nota:"),
              widget.isExpense
                  ? DetailInputButton(
                      label: "Precio:",
                      color: EXPENSE_COLOR,
                      value: "-\$$_calculatorInput",
                      onPressedFun: () {
                        _showCalculatorDialog(context);
                      },
                    )
                  : DetailInputButton(
                      label: "Ingreso:",
                      color: INCOME_COLOR,
                      value: "+\$$_calculatorInput",
                      onPressedFun: () {
                        _showCalculatorDialog(context);
                      },
                    ),
              DetailInputButton(
                label: "Dia:",
                color: Theme.of(context).primaryColor,
                value: DateFormat.yMEd().format(_selectedDate),
                onPressedFun: () {
                  _presentDatePicker();
                },
              ),
              InkWell(
                onTap: () => submitData(context, providerData),
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
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            widget.isExpense
                                ? "Agregar gasto de ${expenseCategories[selectedCategoryIndex].toString().split(".").last} el ${_selectedDate.day}"
                                : "Agregar ingreso de ${incomeCategories[selectedCategoryIndex].toString().split(".").last} el ${_selectedDate.day}",
                            style: TextStyle(
                              color: TEXT_COLOR,
                            ),
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

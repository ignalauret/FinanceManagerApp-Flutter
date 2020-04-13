import 'package:financemanager/Database/db_helper.dart';
import 'package:financemanager/models/wallet.dart';

import '../../models/transaction.dart';
import '../../utils/constants.dart';
import '../calculator/calculator_dialog.dart';
import '../cards/category_selection_card.dart';
import '../color_bar.dart';
import '../userInput/detail_input_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../userInput/text_input.dart';

class NewTransactionSheet extends StatefulWidget {
  final bool isExpense;
  final Transaction _transactionToEdit;
  final bool editMode;

  NewTransactionSheet(this.isExpense)
      : _transactionToEdit = null,
        this.editMode = false;

  NewTransactionSheet.edit(this._transactionToEdit)
      : isExpense = _transactionToEdit.isExpense,
        this.editMode = true;

  @override
  _NewTransactionSheetState createState() => _NewTransactionSheetState();
}

class _NewTransactionSheetState extends State<NewTransactionSheet> {
  String _calculatorInput = "0";
  DateTime _selectedDate = DateTime.now();
  int _selectedCategoryIndex = 0;
  String _selectedNote = "";
  int _selectedWalletId = 1;
  bool editModeSetted = false;

  void setEditMode() {
    _calculatorInput = widget._transactionToEdit.amount.toStringAsFixed(2);
    _selectedDate = widget._transactionToEdit.date;
    _selectedNote = widget._transactionToEdit.note;
    _selectedWalletId = widget._transactionToEdit.walletId;
    _selectedCategoryIndex = widget.isExpense
        ? expenseCategories.indexOf(widget._transactionToEdit.category)
        : incomeCategories.indexOf(widget._transactionToEdit.category);
    editModeSetted = true;
  }

  void submitData(BuildContext ctx) {
    final enteredNote = _selectedNote;
    final enteredAmount = double.parse(_calculatorInput);
    if (enteredNote.isEmpty || enteredAmount <= 0) return;
    Transaction transaction = Transaction(
      id: widget.editMode ? widget._transactionToEdit.id : null,
      note: enteredNote,
      amount: enteredAmount,
      date: _selectedDate,
      isExpense: widget.isExpense,
      walletId: _selectedWalletId,
      category: widget.isExpense
          ? expenseCategories[_selectedCategoryIndex]
          : incomeCategories[_selectedCategoryIndex],
    );
    if (widget.editMode) {
      DBHelper().editTransaction(transaction).then((_) => Navigator.of(context).pop());
    } else
      DBHelper().addNewTransaction(transaction).then((_) => Navigator.of(context).pop());

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
      _selectedCategoryIndex = index;
    });
  }

  void _newNote(String note) {
    setState(() {
      _selectedNote = note;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (widget.editMode && !editModeSetted) setEditMode();
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
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
                        child: FutureBuilder<List<Wallet>>(
                            future: DBHelper().getWallets(),
                            builder: (context, snapshot) {
                              if (snapshot != null && snapshot.hasData) {
                                return DropdownButton<int>(
                                  style: MENU_TEXT_STYLE,
                                  value: snapshot.data
                                      .firstWhere(
                                          (wal) => wal.id == _selectedWalletId)
                                      .id,
                                  items: snapshot.data
                                      .map((wal) => DropdownMenuItem<int>(
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
                                );
                              }
                              return new Container(
                                alignment: AlignmentDirectional.center,
                                child: new CircularProgressIndicator(),
                              );
                            })),
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
                          index == _selectedCategoryIndex,
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
                TextInput(_newNote, "Nota:", _selectedNote),
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
                          FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              widget.isExpense
                                  ? "Agregar gasto de ${expenseCategories[_selectedCategoryIndex].toString().split(".").last} el ${_selectedDate.day}"
                                  : "Agregar ingreso de ${incomeCategories[_selectedCategoryIndex].toString().split(".").last} el ${_selectedDate.day}",
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
      ),
    );
  }
}

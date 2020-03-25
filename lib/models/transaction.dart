import 'package:financemanager/utils/tools.dart';
import 'package:flutter/material.dart';

import '../utils/constants.dart';

enum TransactionCategories {
  Comida,
  Transporte,
  Salud,
  Salario,
  Compras,
  Inversiones,
}

const incomeCategories = [
  TransactionCategories.Salario,
  TransactionCategories.Inversiones,
];

const expenseCategories = [
  TransactionCategories.Compras,
  TransactionCategories.Salud,
  TransactionCategories.Comida,
  TransactionCategories.Transporte,
];

const TransactionCategoryColor = {
  TransactionCategories.Comida: CATEGORY_FOOD_COLOR,
  TransactionCategories.Transporte: CATEGORY_TRANSPORTATION_COLOR,
  TransactionCategories.Salud: CATEGORY_MEDICAL_COLOR,
  TransactionCategories.Salario: CATEGORY_SALARY_COLOR,
  TransactionCategories.Inversiones: Colors.green,
  TransactionCategories.Compras: Colors.red,
};

const TransactionCategoryIcon = {
  TransactionCategories.Comida: Icons.fastfood,
  TransactionCategories.Transporte: Icons.directions_car,
  TransactionCategories.Salud: Icons.healing,
  TransactionCategories.Salario: Icons.attach_money,
  TransactionCategories.Inversiones: Icons.account_balance,
  TransactionCategories.Compras: Icons.shop,
};

const TransactionCategoryList = [
  TransactionCategories.Salario,
  TransactionCategories.Inversiones,
  TransactionCategories.Compras,
  TransactionCategories.Salud,
  TransactionCategories.Comida,
  TransactionCategories.Transporte,
];

class Transaction {
  final int id; // PK
  final String note;
  final double amount;
  final DateTime date;
  final TransactionCategories category;
  final int walletId;
  final bool isExpense;

  // Los hago named para no tener que acordarme el orden
  Transaction({
    @required this.id,
    @required this.amount,
    @required this.date,
    @required this.note,
    @required this.category,
    @required this.walletId,
    @required this.isExpense,
  });

  Transaction.fromJson(dynamic obj)
      : this.id = obj['tid'],
        this.note = obj['note'],
        this.amount = obj['amount'],
        this.walletId = obj['walletid'],
        this.isExpense = obj['isexpense'] == 1,
        this.date = intToDate(obj['date'] as int),
        this.category = TransactionCategoryList[obj['category']];
}

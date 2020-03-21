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

class Transaction {
  final String id; // PK
  final String note;
  final double amount;
  final DateTime date;
  final TransactionCategories category;
  final String walletId;
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
}

import '../../models/transaction.dart';
import '../../utils/constants.dart';
import 'package:flutter/material.dart';

import '../color_bar.dart';

class CategorySelectorCard extends StatelessWidget {
  final int index;
  final bool selected;
  final Function selectCategory;
  final bool isExpense;

  CategorySelectorCard(
      this.index,
      this.selected,
      this.selectCategory,
      this.isExpense,
      );
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectCategory(index),
      child: Card(
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CARDS_BORDER_RADIUS),
          side: BorderSide(color: CARDS_COLOR, width: 2),
        ),
        color: selected ? CARDS_COLOR : BACKGROUND_COLOR,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 0,
            left: 0,
            right: 0,
          ),
          child: Column(
            children: <Widget>[
              Icon(
                TransactionCategoryIcon[isExpense
                    ? expenseCategories[index]
                    : incomeCategories[index]],
                size: 32,
                color: selected ? Colors.white : Colors.grey,
              ),
              ColorBar(
                color: TransactionCategoryColor[isExpense
                    ? expenseCategories[index]
                    : incomeCategories[index]],
                height: 42,
                vertical: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}

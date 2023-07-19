import 'package:expense_tracker/models/expe.dart';
import 'package:expense_tracker/widgets/exp_list/exp_item.dart';
import 'package:flutter/material.dart';

class ExpList extends StatelessWidget {
  const ExpList({super.key, required this.expenses, required this.onRemoveExp});

  final void Function(Expe expe) onRemoveExp;
  final List<Expe> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (c, i) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.5),
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),
              key: ValueKey(expenses[i]),
              onDismissed: (direction) {
                onRemoveExp(expenses[i]);
              },
              child: ExpenseItem(expenses[i]),
            ));
  }
}

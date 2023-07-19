import 'package:expense_tracker/widgets/exp_list/enpe_list.dart';
import 'package:expense_tracker/widgets/exp_list/new_exp.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expe.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExState();
  }
}

class _ExState extends State<Expenses> {
  final List<Expe> _registeredExpenses = [
    Expe(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expe(
        title: 'Cinema',
        amount: 8.47,
        date: DateTime.now(),
        category: Category.leisure)
  ];
  _openAddExp() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (c) => NewExp(onAddExpense: _addExp),
    );
  }

  void _addExp(Expe expe) {
    setState(() {
      _registeredExpenses.add(expe);
    });
  }

  void _removed(Expe expe) {
    final expIndex = _registeredExpenses.indexOf(expe);
    setState(() {
      _registeredExpenses.remove(expe);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expIndex, expe);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text('No Expenses found, Start Adding some!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpList(
        expenses: _registeredExpenses,
        onRemoveExp: _removed,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Expense Tracker'),
          actions: [
            IconButton(onPressed: _openAddExp, icon: const Icon(Icons.add))
          ],
        ),
        body: width < 600
            ? Column(children: [
                Chart(
                  exps: _registeredExpenses,
                ),
                Expanded(child: mainContent),
              ])
            : Row(
                children: [
                  Expanded(
                    child: Chart(
                      exps: _registeredExpenses,
                    ),
                  ),
                  Expanded(child: mainContent),
                ],
              ));
  }
}

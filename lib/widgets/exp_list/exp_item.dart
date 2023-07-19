import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expe.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expe, {super.key});
  final Expe expe;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            expe.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                '\$${expe.amount.toStringAsFixed(2)}',
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(CategoryIcons[expe.category]),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(expe.FormattedDate),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expe.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.exps});
  final List<Expe> exps;
  List<ExpBucket> get buckets {
    return [
      ExpBucket.forCategry(exps, Category.food),
      ExpBucket.forCategry(exps, Category.leisure),
      ExpBucket.forCategry(exps, Category.trevel),
      ExpBucket.forCategry(exps, Category.work),
    ];
  }

  double get maxTotal {
    double maxTotal = 0;
    for (final bucket in buckets) {
      if (bucket.totalExp > maxTotal) {
        maxTotal = bucket.totalExp;
      }
    }
    return maxTotal;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (final bucket in buckets)
                ChartBar(
                  fill: bucket.totalExp / maxTotal,
                )
            ],
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: buckets
              .map(
                (bucket) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      CategoryIcons[bucket.category],
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.7),
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ]),
    );
  }
}

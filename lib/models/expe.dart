import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { food, trevel, work, leisure }

const CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.trevel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expe {
  Expe(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final Category category;

  String get FormattedDate {
    return formatter.format(date);
  }
}

class ExpBucket {
  const ExpBucket({
    required this.category,
    required this.expes,
  });
  ExpBucket.forCategry(List<Expe> allExpes, this.category)
      : expes = allExpes.where((expe) => expe.category == category).toList();
  final Category category;
  final List<Expe> expes;
  double get totalExp {
    double sum = 0;
    for (final expe in expes) {
      sum += expe.amount;
    }
    return sum;
  }
}

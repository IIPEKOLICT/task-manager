import 'package:flutter/material.dart';

enum PriorityEnum {
  low('LOW', 'Низкий', Colors.grey),
  normal('NORMAL', 'Обычный', Colors.green),
  high('HIGH', 'Высокий', Colors.red);

  final String value;
  final String label;
  final Color color;

  const PriorityEnum(this.value, this.label, this.color);
}

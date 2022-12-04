import 'package:flutter/material.dart';

enum StatusEnum {
  todo('TODO', 'Планируется', Colors.grey),
  inProgress('IN_PROGRESS', 'В процессе', Colors.lime),
  completed('COMPLETED', 'Выполнено', Colors.green);

  final String value;
  final String label;
  final Color color;

  const StatusEnum(this.value, this.label, this.color);
}

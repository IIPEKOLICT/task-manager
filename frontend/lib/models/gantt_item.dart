import 'package:flutter/material.dart';
import 'package:frontend/models/base/base_entity.dart';

class GanttItem {
  String taskId;
  String taskName;
  Color taskColor;
  int hours;
  int startOffsetHours;
  int endOffsetHours;

  GanttItem({
    this.taskId = '',
    this.taskName = '',
    this.taskColor = Colors.white10,
    this.hours = 0,
    this.startOffsetHours = 0,
    this.endOffsetHours = 0,
  });

  factory GanttItem.fromJson(Map<String, dynamic> json) {
    return GanttItem(
      taskId: json['taskId'],
      taskName: json['taskName'],
      taskColor: BaseEntity.parseColorFromJson(json['taskColor']),
      hours: json['hours'],
      startOffsetHours: json['startOffsetHours'],
      endOffsetHours: json['endOffsetHours'],
    );
  }
}

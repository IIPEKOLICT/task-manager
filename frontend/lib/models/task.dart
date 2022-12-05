import 'package:flutter/material.dart';
import 'package:frontend/enums/priority.enum.dart';
import 'package:frontend/models/base/base_entity.dart';
import 'package:frontend/models/tag.dart';
import 'package:frontend/models/user.dart';

import '../enums/status.enum.dart';

class Task extends BaseEntity {
  String createdBy;
  String project;
  User? assignedTo;
  List<String> blockedBy;
  num trackedTime;
  num commentsAmount;
  num notesAmount;
  num attachmentsAmount;
  List<Tag> tags;
  String title;
  String description;
  Color color;
  PriorityEnum priority;
  StatusEnum status;
  num expectedHours;
  bool canEdit;

  Task({
    super.id,
    this.createdBy = '',
    this.project = '',
    this.assignedTo,
    this.blockedBy = const [],
    this.trackedTime = 0,
    this.commentsAmount = 0,
    this.notesAmount = 0,
    this.attachmentsAmount = 0,
    this.tags = const [],
    this.title = '',
    this.description = '',
    this.color = Colors.white10,
    this.priority = PriorityEnum.normal,
    this.status = StatusEnum.todo,
    this.expectedHours = 0,
    this.canEdit = false,
    super.createdAt,
    super.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      createdBy: json['createdBy'],
      project: json['project'],
      assignedTo: json['assignedTo'] != null ? User.fromJson(json['assignedTo'] as Map<String, dynamic>) : null,
      blockedBy: (json['blockedBy'] as List)?.map((item) => item as String)?.toList() ?? [],
      trackedTime: json['trackedTime'],
      commentsAmount: json['commentsAmount'],
      notesAmount: json['notesAmount'],
      attachmentsAmount: json['attachmentsAmount'],
      tags: (json['tags'] as List)
              ?.map((item) => item as Map<String, dynamic>)
              ?.map((item) => Tag.fromJson(item))
              .toList() ??
          [],
      title: json['title'],
      description: json['description'],
      priority: PriorityEnum.values.firstWhere(
        (element) => element.value == json['priority'],
        orElse: () => PriorityEnum.normal,
      ),
      status: StatusEnum.values.firstWhere(
        (element) => element.value == json['status'],
        orElse: () => StatusEnum.todo,
      ),
      expectedHours: json['expectedHours'],
      canEdit: json['canEdit'],
      color: BaseEntity.parseColorFromJson(json['color']),
      createdAt: BaseEntity.parseDateFromJson(json['createdAt']),
      updatedAt: BaseEntity.parseDateFromJson(json['updatedAt']),
    );
  }
}

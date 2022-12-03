import 'package:flutter/material.dart';
import 'package:frontend/models/base/base_entity.dart';

class Tag extends BaseEntity {
  String project;
  String createdBy;
  String name;
  Color color;

  Tag({
    super.id,
    this.project = '',
    this.createdBy = '',
    this.name = '',
    this.color = Colors.white10,
    super.createdAt,
    super.updatedAt,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['_id'],
      project: json['project'],
      createdBy: json['createdBy'],
      name: json['name'],
      color: BaseEntity.parseColorFromJson(json['color']),
      createdAt: BaseEntity.parseDateFromJson(json['createdAt']),
      updatedAt: BaseEntity.parseDateFromJson(json['updatedAt']),
    );
  }
}

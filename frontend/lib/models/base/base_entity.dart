import 'package:flutter/material.dart';

abstract class BaseEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BaseEntity({this.id = '', this.createdAt, this.updatedAt});

  bool get isEdited {
    return updatedAt?.isBefore(DateTime.now()) ?? false;
  }

  static DateTime? parseDateFromJson(dynamic jsonDate) {
    return jsonDate == null ? null : DateTime.parse(jsonDate);
  }

  static Color parseColorFromJson(dynamic jsonColor) {
    try {
      return jsonColor == null
          ? Colors.white10
          : Color(int.parse('ff${jsonColor.toString().replaceAll('#', '')}', radix: 16));
    } catch (e) {
      return Colors.white10;
    }
  }
}

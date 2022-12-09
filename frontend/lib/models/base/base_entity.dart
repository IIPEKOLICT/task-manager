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
    return jsonDate == null ? null : DateTime.parse(jsonDate).toLocal();
  }

  static String renderTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  static String renderDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
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

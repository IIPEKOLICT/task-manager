import 'package:frontend/models/base/base_entity.dart';
import 'package:frontend/models/user.dart';

class Work extends BaseEntity {
  User? createdBy;
  String task;
  String description;
  DateTime? startDate;
  DateTime? endDate;
  bool canEdit;

  Work({
    super.id,
    this.createdBy,
    this.task = '',
    this.description = '',
    this.startDate,
    this.endDate,
    super.createdAt,
    super.updatedAt,
    this.canEdit = false,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      id: json['_id'],
      createdBy: json['createdBy'] != null ? User.fromJson(json['createdBy'] as Map<String, dynamic>) : null,
      task: json['task'],
      description: json['description'],
      startDate: BaseEntity.parseDateFromJson(json['startDate']),
      endDate: BaseEntity.parseDateFromJson(json['endDate']),
      createdAt: BaseEntity.parseDateFromJson(json['createdAt']),
      updatedAt: BaseEntity.parseDateFromJson(json['updatedAt']),
      canEdit: json['canEdit'],
    );
  }

  String renderDates() {
    if (startDate == null || endDate == null) return '';

    String start = '${BaseEntity.renderDate(startDate!)} ${BaseEntity.renderTime(startDate!)}';
    String end = '${BaseEntity.renderDate(endDate!)} ${BaseEntity.renderTime(endDate!)}';

    return '$start - $end';
  }
}

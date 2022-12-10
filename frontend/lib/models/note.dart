import 'package:frontend/models/base/base_entity.dart';
import 'package:frontend/models/user.dart';

class Note extends BaseEntity {
  User? createdBy;
  String task;
  String header;
  String text;
  bool canEdit;

  Note({
    super.id,
    this.createdBy,
    this.task = '',
    this.header = '',
    this.text = '',
    super.createdAt,
    super.updatedAt,
    this.canEdit = false,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'],
      createdBy: json['createdBy'] != null ? User.fromJson(json['createdBy'] as Map<String, dynamic>) : null,
      task: json['task'],
      header: json['header'],
      text: json['text'],
      createdAt: BaseEntity.parseDateFromJson(json['createdAt']),
      updatedAt: BaseEntity.parseDateFromJson(json['updatedAt']),
      canEdit: json['canEdit'],
    );
  }
}

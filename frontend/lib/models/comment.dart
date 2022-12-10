import 'package:frontend/models/base/base_entity.dart';
import 'package:frontend/models/user.dart';

class Comment extends BaseEntity {
  User? createdBy;
  String task;
  String text;
  bool canEdit;

  Comment({
    super.id,
    this.createdBy,
    this.task = '',
    this.text = '',
    super.createdAt,
    super.updatedAt,
    this.canEdit = false,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['_id'],
      createdBy: json['createdBy'] != null ? User.fromJson(json['createdBy'] as Map<String, dynamic>) : null,
      task: json['task'],
      text: json['text'],
      createdAt: BaseEntity.parseDateFromJson(json['createdAt']),
      updatedAt: BaseEntity.parseDateFromJson(json['updatedAt']),
      canEdit: json['canEdit'],
    );
  }
}

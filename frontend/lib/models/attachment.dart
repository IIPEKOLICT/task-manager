import 'package:frontend/models/base/base_entity.dart';

class Attachment extends BaseEntity {
  String createdBy;
  String task;
  String type;
  String name;
  String? url;
  bool canEdit;

  Attachment({
    super.id,
    this.createdBy = '',
    this.task = '',
    this.type = '',
    this.name = '',
    this.url,
    super.createdAt,
    super.updatedAt,
    this.canEdit = false,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['_id'],
      createdBy: json['createdBy'],
      task: json['task'],
      type: json['type'],
      name: json['name'],
      url: json['url'],
      createdAt: BaseEntity.parseDateFromJson(json['createdAt']),
      updatedAt: BaseEntity.parseDateFromJson(json['updatedAt']),
      canEdit: json['canEdit'],
    );
  }
}

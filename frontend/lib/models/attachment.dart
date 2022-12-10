import 'package:frontend/models/base/base_entity.dart';

import '../enums/file_type.enum.dart';

class Attachment extends BaseEntity {
  String createdBy;
  String task;
  FileTypeEnum type;
  String name;
  String? url;
  bool canEdit;

  Attachment({
    super.id,
    this.createdBy = '',
    this.task = '',
    this.type = FileTypeEnum.other,
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
      type: FileTypeEnum.values.firstWhere(
        (element) => element.value == json['type'],
        orElse: () => FileTypeEnum.other,
      ),
      name: json['name'],
      url: json['url'],
      createdAt: BaseEntity.parseDateFromJson(json['createdAt']),
      updatedAt: BaseEntity.parseDateFromJson(json['updatedAt']),
      canEdit: json['canEdit'],
    );
  }
}

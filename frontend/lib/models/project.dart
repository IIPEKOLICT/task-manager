import 'package:frontend/models/base/base_entity.dart';

class Project extends BaseEntity {
  String createdBy;
  List<String> members;
  String name;
  bool canEdit;

  Project(
      {super.id,
      this.createdBy = '',
      this.members = const [],
      this.name = '',
      super.createdAt,
      super.updatedAt,
      this.canEdit = false});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        id: json['_id'],
        createdBy: json['createdBy'],
        members: (json['members'] as List)?.map((item) => item as String)?.toList() ?? [],
        name: json['name'],
        createdAt: BaseEntity.parseDateFromJson(json['createdAt']),
        updatedAt: BaseEntity.parseDateFromJson(json['updatedAt']),
        canEdit: json['canEdit']);
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'createdBy': createdBy,
      'members': members,
      'name': name,
      'createdAt': createdAt?.toString(),
      'updatedAt': updatedAt?.toString()
    };
  }
}

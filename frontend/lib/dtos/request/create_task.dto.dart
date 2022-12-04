import 'package:frontend/enums/priority.enum.dart';
import 'package:frontend/enums/status.enum.dart';

class CreateTaskDto {
  final String assignedTo;
  final List<String> blockedBy;
  final List<String> tags;
  final String title;
  final String description;
  final PriorityEnum priority;
  final StatusEnum status;
  final num? expectedHours;

  CreateTaskDto({
    required this.assignedTo,
    this.blockedBy = const [],
    this.tags = const [],
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    this.expectedHours,
  });

  Map<String, dynamic> get json {
    return {
      'assignedTo': assignedTo,
      'blockedBy': blockedBy,
      'tags': tags,
      'title': title,
      'description': description,
      'priority': priority.value,
      'status': status.value,
      'expectedHours': expectedHours,
    };
  }
}

class CreateTaskDto {
  final String assignedTo;
  final List<String> blockedBy;
  final List<String> tags;
  final String title;
  final String description;
  final String priority;
  final String status;
  final num? expectedHours;

  CreateTaskDto({
    this.assignedTo = '',
    this.blockedBy = const [],
    this.tags = const [],
    this.title = '',
    this.description = '',
    this.priority = 'NORMAL',
    this.status = 'TODO',
    this.expectedHours,
  });

  Map<String, dynamic> get json {
    return {
      'assignedTo': assignedTo,
      'blockedBy': blockedBy,
      'tags': tags,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'expectedHours': expectedHours,
    };
  }
}

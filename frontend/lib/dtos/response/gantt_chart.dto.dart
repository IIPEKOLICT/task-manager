import 'package:frontend/models/gantt_item.dart';

class GanttChartDto {
  final int hours;
  final List<GanttItem> items;

  GanttChartDto({
    this.hours = 0,
    this.items = const [],
  });

  factory GanttChartDto.fromJSON(Map<String, dynamic> json) {
    return GanttChartDto(
      hours: json['hours'],
      items: (json['items'] as List)
              ?.map((item) => item as Map<String, dynamic>)
              ?.map((item) => GanttItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

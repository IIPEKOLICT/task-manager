import 'package:flutter/material.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:provider/provider.dart';

import '../../../../di/app.module.dart';
import '../../../../models/gantt_item.dart';
import '../../../../view_models/gantt.view_model.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  static Widget _eventBuilder(
    BuildContext context,
    int index,
    GanttEventBase event,
    Color eventColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: event.suggestedColor,
        border: BorderDirectional(
          top: index == 0 ? const BorderSide() : BorderSide.none,
          start: const BorderSide(),
          end: const BorderSide(),
          bottom: const BorderSide(),
        ),
      ),
      child: Center(
        child: Text(
          event.getDisplayName(context),
        ),
      ),
    );
  }

  static Widget _eventCellBuilder(
    BuildContext context,
    DateTime eventStartDate,
    DateTime eventEndDate,
    bool isHoliday,
    GanttEventBase event,
    DateTime dayDate,
    Color eventColor,
  ) {
    final isWithinEvent = !DateUtils.isSameDay(eventStartDate, eventEndDate) &&
        (DateUtils.isSameDay(eventStartDate, dayDate) ||
            dayDate.isAfter(eventStartDate) && dayDate.isBefore(eventEndDate));

    final color = isHoliday
        ? Colors.grey
        : isWithinEvent
            ? event.suggestedColor
            : null;

    return Container(
      decoration: BoxDecoration(
        color: isHoliday ? color : null,
        border: const BorderDirectional(
          top: BorderSide.none,
          bottom: BorderSide.none,
          start: BorderSide(),
        ),
      ),
      child: !isWithinEvent || isHoliday
          ? null
          : LayoutBuilder(
              builder: (context, constraints) => Center(
                child: Container(
                  height: constraints.maxHeight / 2,
                  color: color,
                ),
              ),
            ),
    );
  }

  static String _getWeekDaySymbol(WeekDay weekDay) {
    switch (weekDay.symbol) {
      case 'M':
        return 'Пн';
      case 'Tu':
        return 'Вт';
      case 'W':
        return 'Ср';
      case 'Th':
        return 'Чт';
      case 'F':
        return 'Пт';
      case 'Sa':
        return 'Сб';
      default:
        return 'Вс';
    }
  }

  static Widget _dayHeaderBuilder(BuildContext context, DateTime date) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        border: const BorderDirectional(
          bottom: BorderSide(),
          start: BorderSide(),
        ),
      ),
      child: Center(
        child: Text(
          _getWeekDaySymbol(WeekDay.fromIntWeekday(date.weekday)),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GanttViewModel>();

    return Scaffold(
      body: SingleChildScrollView(
        child: viewModel.isLoading
            ? const LinearProgressIndicator()
            : GanttChartView(
                maxDuration: Duration(days: viewModel.getHours()),
                startDate: DateTime.now(),
                stickyAreaWidth: 240,
                showStickyArea: true,
                showDays: true,
                startOfTheWeek: WeekDay.monday,
                weekEnds: const {},
                stickyAreaEventBuilder: _eventBuilder,
                eventCellPerDayBuilder: _eventCellBuilder,
                dayHeaderBuilder: _dayHeaderBuilder,
                events: viewModel.getItems().map((GanttItem item) {
                  return GanttRelativeEvent(
                    relativeToStart: Duration(hours: item.startOffsetHours),
                    duration: Duration(hours: item.hours),
                    displayName: item.taskName,
                    suggestedColor: item.taskColor,
                  );
                }).toList(),
              ),
      ),
    );
  }

  static Widget onCreate() {
    return ChangeNotifierProvider(
      create: (BuildContext context) => injector.get<GanttViewModel>(param1: context),
      child: const ChartPage(),
    );
  }
}

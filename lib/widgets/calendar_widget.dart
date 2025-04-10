// lib/widgets/calendar_widget.dart
import 'package:flutter/material.dart';
import 'package:machinetest_10042025/models/meeting_model.dart';
import 'package:machinetest_10042025/widgets/calender_cell.dart';
import 'package:machinetest_10042025/widgets/month_picker_widget.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  Color _getEventIndicatorColor(BuildContext context, List<Event> dateEvents) {
    if (dateEvents.any((event) => event.isTodayEvent)) {
      return Theme.of(context).primaryColor; // Today's events
    } else if (dateEvents.any((event) => event.isUpcomingEvent)) {
      return Colors.green; // Upcoming events
    } else {
      return Colors.grey; // Past events
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final currentMonth = eventProvider.currentMonth;
    final selectedDate = eventProvider.selectedDate;
    final firstDay = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDay = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final daysInMonth = lastDay.day;
    final firstWeekday = firstDay.weekday % 7;

    return Column(
      children: [
        MonthPickerWidget(
          currentMonth: currentMonth,
          onChanged: (month) => eventProvider.setCurrentMonth(month),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xff131925)),
          child: Column(
            children: [
              const Row(
                children: [
                  _WeekdayHeader(day: 'Mon'),
                  _WeekdayHeader(day: 'Tue'),
                  _WeekdayHeader(day: 'Wed'),
                  _WeekdayHeader(day: 'Thu'),
                  _WeekdayHeader(day: 'Fri'),
                  _WeekdayHeader(day: 'Sat'),
                  _WeekdayHeader(day: 'Sun'),
                ],
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1.0,
                ),
                itemCount: daysInMonth + firstWeekday - 1,
                itemBuilder: (context, index) {
                  if (index < firstWeekday - 1) {
                    return const SizedBox.shrink();
                  }

                  final day = index - firstWeekday + 2;
                  final date =
                      DateTime(currentMonth.year, currentMonth.month, day);
                  final isSelected = selectedDate.year == date.year &&
                      selectedDate.month == date.month &&
                      selectedDate.day == date.day;

                  final dateEvents = eventProvider.events
                      .where((event) =>
                          event.dateOnly ==
                          DateTime(date.year, date.month, date.day))
                      .toList();

                  return CalendarCell(
                    date: date,
                    currentMonth: currentMonth,
                    isSelected: isSelected,
                    events: dateEvents,
                  );
                },
              ),
            ],
          ),
        ),

        // Calendar grid
      ],
    );
  }
}

class _WeekdayHeader extends StatelessWidget {
  final String day;

  const _WeekdayHeader({required this.day});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          day,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

// lib/widgets/calendar_cell.dart
import 'package:flutter/material.dart';
import 'package:machinetest_10042025/models/meeting_model.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';

class CalendarCell extends StatelessWidget {
  final DateTime date;
  final DateTime currentMonth;
  final bool isSelected;
  final List<Event> events;

  const CalendarCell({
    super.key,
    required this.date,
    required this.currentMonth,
    required this.isSelected,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isToday = _isToday(date);
    final isCurrentMonth = date.month == currentMonth.month;
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    return GestureDetector(
      onTap: () => eventProvider.setSelectedDate(date),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : Colors.transparent,
          shape: BoxShape.circle,
          border: isToday
              ? Border.all(
                  color: isToday
                      ? Colors.amber
                      : isSelected
                          ? theme.primaryColor
                          : Colors.grey.shade300,
                  width: isToday ? 1.5 : 1.0,
                )
              : null,
        ),
        child: Stack(
          children: [
            // Date number
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontWeight: isSelected || isToday
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 13,
                      color: isToday
                          ? Colors.white
                          : isSelected
                              ? Colors.white
                              : isCurrentMonth
                                  ? Colors.white
                                  : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Event indicators
            if (events.isNotEmpty)
              Positioned(
                top: 2,
                right: 2,
                child: _EventIndicators(events: events),
              ),
          ],
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}

class _EventIndicators extends StatelessWidget {
  final List<Event> events;

  const _EventIndicators({required this.events});

  @override
  Widget build(BuildContext context) {
    final todayEvents = events.where((e) => e.isTodayEvent).toList();
    final upcomingEvents = events.where((e) => e.isUpcomingEvent).toList();
    final pastEvents = events.where((e) => e.isPastEvent).toList();
    final conflictEvent = events.where((e) {
      for (var item in e.items) {
        if (item.conflicted) {
          return true;
        }
      }
      return false;
    }).toList();
    if (conflictEvent.isNotEmpty) {
      return _buildIndicator(Colors.red);
    } else if (todayEvents.isNotEmpty) {
      return _buildIndicator(Colors.yellow);
    } else if (upcomingEvents.isNotEmpty && pastEvents.isNotEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicator(Colors.grey),
          const SizedBox(width: 2),
          _buildIndicator(Colors.green),
        ],
      );
    } else if (upcomingEvents.isNotEmpty) {
      return _buildIndicator(Colors.green);
    } else {
      return _buildIndicator(Colors.grey);
    }
  }

  Widget _buildIndicator(Color color) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

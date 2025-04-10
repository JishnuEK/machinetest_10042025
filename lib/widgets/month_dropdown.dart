// lib/widgets/month_dropdown.dart
import 'package:flutter/material.dart';
import 'package:machinetest_10042025/utils/date_formater.dart';

class MonthDropdown extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onChanged;

  const MonthDropdown({
    super.key,
    required this.selectedDate,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: selectedDate.month,
      icon: const Icon(Icons.arrow_drop_down),
      style: Theme.of(context).textTheme.titleMedium,
      underline: Container(
        height: 0,
      ),
      onChanged: (int? newMonth) {
        if (newMonth != null) {
          onChanged(DateTime(selectedDate.year, newMonth, 1));
        }
      },
      items: List.generate(12, (index) => index + 1).map((int month) {
        return DropdownMenuItem<int>(
          value: month,
          child: Text(
            getMonthNameMMM(month),
          ),
        );
      }).toList(),
    );
  }
}

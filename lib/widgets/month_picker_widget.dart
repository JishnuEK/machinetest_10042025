// lib/widgets/month_picker.dart
import 'package:flutter/material.dart';
import 'month_dropdown.dart';
import 'year_dropdown.dart';

class MonthPickerWidget extends StatelessWidget {
  final DateTime currentMonth;
  final Function(DateTime) onChanged;

  const MonthPickerWidget({
    super.key,
    required this.currentMonth,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MonthDropdown(
            selectedDate: currentMonth,
            onChanged: onChanged,
          ),
          YearDropdown(
            selectedDate: currentMonth,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

// lib/widgets/year_dropdown.dart
import 'package:flutter/material.dart';

class YearDropdown extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onChanged;
  final int yearRange;

  const YearDropdown({
    super.key,
    required this.selectedDate,
    required this.onChanged,
    this.yearRange = 10,
  });

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final years = List.generate(
      yearRange + 1,
      (index) => currentYear - yearRange + index,
    );

    return DropdownButton<int>(
      value: selectedDate.year,
      icon: const Icon(Icons.arrow_drop_down),
      style: Theme.of(context).textTheme.titleMedium,
      underline: Container(
        height: 0,
      ),
      onChanged: (int? newYear) {
        if (newYear != null) {
          onChanged(DateTime(newYear, selectedDate.month, 1));
        }
      },
      items: years.map((int year) {
        return DropdownMenuItem<int>(
          value: year,
          child: Text(
            year.toString(),
          ),
        );
      }).toList(),
    );
  }
}

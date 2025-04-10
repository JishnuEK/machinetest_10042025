import 'package:intl/intl.dart';

String FormatDatedmyy(DateTime date) {
  try {
    return DateFormat('yyyy-MM-dd').format(date);
  } catch (e) {
    return '';
  }
}

String customFormatDatedmyy(DateTime date) {
  try {
    return DateFormat('EEEE, MMMM dd').format(date);
  } catch (e) {
    return '';
  }
}

String getMonthName(DateTime date) {
  try {
    return DateFormat('MMM').format(date);
  } catch (e) {
    return '';
  }
}

String getMonthNameMMM(int monthNumber) {
  if (monthNumber < 1 || monthNumber > 12) {
    return 'Invalid Month';
  }

  DateTime date = DateTime(2023, monthNumber);
  return DateFormat('MMMM').format(date);
}

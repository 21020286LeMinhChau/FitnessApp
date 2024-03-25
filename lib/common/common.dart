import 'package:intl/intl.dart';
String dateToString(DateTime date, {String formatStr = "dd/MM/yyyy hh:mm a"}) {
  var format = DateFormat(formatStr);
  return format.format(date);
}


String getDayTitle(String dateStr) {
  final format = DateFormat('dd/MM/yyyy hh:mm a');
  DateTime inputDate;
  try {
    inputDate = format.parse(dateStr);
  } catch (e) {
    return 'Invalid date format';
  }

  final today = DateTime.now();
  final inputDateWithoutTime = DateTime(inputDate.year, inputDate.month, inputDate.day);
  final todayWithoutTime = DateTime(today.year, today.month, today.day);

  if (inputDateWithoutTime == todayWithoutTime) {
    return 'Today';
  } else {
    return DateFormat('dd/MM/yyyy').format(inputDate);
  }
}
String getStringDateToOtherFormate(String dateStr, {String outFormatStr = "dd/MM/yyyy hh:mm a"}) {
  // return hour only
  final format = DateFormat('dd/MM/yyyy hh:mm a');
  DateTime inputDate;
  try {
    inputDate = format.parse(dateStr);
  } catch (e) {
    return 'Invalid date format';
  }
  return DateFormat('h:mm a').format(inputDate);
}


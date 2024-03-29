import 'package:intl/intl.dart';
String dateToString(DateTime date, {String formatStr = "dd/MM/yyyy hh:mm a"}) {
  var format = DateFormat(formatStr);
  return format.format(date);
}

String getTime(int value, {String formatStr = "hh:mm a"}) {
  var format = DateFormat(formatStr);
  return format.format(
      DateTime.fromMillisecondsSinceEpoch(value * 60 * 1000, isUtc: true));
}

String getStringDateToOtherFormate(String dateStr,
    {String inputFormatStr = "dd/MM/yyyy hh:mm aa",
    String outFormatStr = "hh:mm a"}) {
  var format = DateFormat(outFormatStr);
  return format.format(stringToDate(dateStr, formatStr: inputFormatStr));
}

DateTime stringToDate(String dateStr, {String formatStr = "hh:mm a"}) {
  var format = DateFormat(formatStr);
  return format.parse(dateStr);
}

DateTime dateToStartDate(DateTime date) {
  return DateTime(date.year, date.month, date.day);
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
// String getStringDateToOtherFormate(String dateStr, {String outFormatStr = "dd/MM/yyyy hh:mm a"}) {
//   // return hour only
//   final format = DateFormat('dd/MM/yyyy hh:mm a');
//   DateTime inputDate;
//   try {
//     inputDate = format.parse(dateStr);
//   } catch (e) {
//     return 'Invalid date format';
//   }
//   return DateFormat('h:mm a').format(inputDate);
// }
// String getDayTitle(String dateStr, {String formatStr = "dd/MM/yyyy hh:mm a"} ) {
//   var date = stringToDate(dateStr, formatStr: formatStr);

//   if (date.isToday) {
//     return "Today";
//   } else if (date.isTomorrow) {
//     return "Tomorrow";
//   } else if (date.isYesterday) {
//     return "Yesterday";
//   } else {
//     var outFormat = DateFormat("E");
//     return outFormat.format(date) ;
//   }
// }

extension DateHelpers on DateTime {
  bool get isToday {
    return DateTime(year, month, day).difference(DateTime.now()).inDays == 0;
  }

  bool get isYesterday {
    return DateTime(year, month, day).difference(DateTime.now()).inDays == -1;
  }

  bool get isTomorrow {
    return DateTime(year, month, day).difference(DateTime.now()).inDays == 1;
  }
}

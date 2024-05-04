import 'package:intl/intl.dart';

String dateFormat(String? date) {
  try {
    if (date == null) {
      return "Нет информации";
    }
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('kk:mm – dd.MM.yyyy').format(dateTime);
  } catch (e) {
    return date.toString();
  }
}

String daysFromMillis(int? millis) {
  if (millis == null) {
    return "Нет информации";
  }
  final now = DateTime.now();
  var dateTime = DateTime.fromMillisecondsSinceEpoch(millis);
  final difference = now.difference(dateTime).inDays;
  if (difference <= 0) {
    return "нет подписки";
  }
  return "$difference";
}

String subDays(String? date) {
  try {
    if (date == null) {
      return "Нет информации";
    }
    final now = DateTime.now();
    DateTime subDays = DateTime.parse(date);
    final difference = subDays.difference(now).inDays;
    if (difference <= 0) {
      return "нет подписки";
    }
    return "$difference";
  } catch (e) {
    return date.toString();
  }
}

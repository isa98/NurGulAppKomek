import 'package:intl/intl.dart';

String dateTimeFormatter(String dateTime) {
  return DateFormat('dd-MM-yyyy, HH:mm').format(DateTime.parse(dateTime));
}

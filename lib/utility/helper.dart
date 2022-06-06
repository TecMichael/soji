import 'package:intl/intl.dart';

class Helper{
  static getCustomFormattedDateTime(String givenDateTime, String dateFormat) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return DateFormat.yMMMEd().format(docDateTime);
  }
}
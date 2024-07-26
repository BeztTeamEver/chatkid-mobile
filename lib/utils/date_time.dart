class DateTimeUtils {
  static String DATE_FORMAT = "dd.MM.yyyy";
  static String DATE_TIME_FORMAT = "dd.MM.yyyy hh:mm";
  static String DATE_TIME_ACTIVITY_FORMAT = "hh:mm , dd.MM.yyyy";

  static String getFormatTime(DateTime dateTime) {
    String hour = dateTime.hour < 10 ? "0${dateTime.hour}" : "${dateTime.hour}";
    String minute =
        dateTime.minute < 10 ? "0${dateTime.minute}" : "${dateTime.minute}";

    return "${hour}:${minute}";
  }

  static String getFormatedDate(DateTime dateTime, String format) {
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;
    int hour = dateTime.hour;
    int minute = dateTime.minute;
    String formatedDate = format
        .replaceFirst(r'MM', toTwoDigit(month))
        .replaceAll(r'yyyy', year.toString())
        .replaceAll(r'dd', toTwoDigit(day))
        .replaceAll(r'hh', toTwoDigit(hour))
        .replaceAll(r'mm', toTwoDigit(minute));
    return formatedDate;
  }

  static String toTwoDigit(int number) {
    return number < 10 ? "0$number" : "$number";
  }

  static String getFormattedDateTime(String dateTime) {
    String time = dateTime.substring(0, 16).split("T")[1];
    String date = dateTime.substring(0, 10).split("-").reversed.join("/");
    return "$time, $date";
  }
}

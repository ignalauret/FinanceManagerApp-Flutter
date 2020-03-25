bool isSameDay(DateTime day1, DateTime day2) {
  return day1.day == day2.day &&
      day1.month == day2.month &&
      day1.year == day2.year;
}

int dateToInt(DateTime date) {
  String day = date.day < 10 ? "0" + date.day.toString() : date.day.toString();
  String month =
      date.month < 10 ? "0" + date.month.toString() : date.month.toString();
  String year = date.year.toString();

  return int.parse("$year$month$day");
}

DateTime intToDate(int date) {
  String sDate = date.toString();
  int year = int.parse(sDate.substring(0, 4));
  int month = int.parse(sDate.substring(4, 6));
  int day = int.parse(sDate.substring(6, 8));
  return DateTime(year, month, day);
}

String timestampToDate(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return "${date.day} ${_getMonthName(date.month)} ${date.year}";
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      return "";
  }
}

String timestampToTime(int timestamp) {
  var now = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var hour = now.hour.toString().padLeft(2, '0');
  var minute = now.minute.toString().padLeft(2, '0');
  var period = int.parse(hour) >= 12 ? 'PM' : 'AM';

  // Convert to 12 hour time format
  hour = (int.parse(hour) % 12).toString().padLeft(2, '0');

  return '$hour:$minute $period';
}

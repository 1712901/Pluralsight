import 'package:intl/intl.dart';

class Format {
  static DateFormat _dateFormat;
  static DateFormat getInstantDateFormat() {
    if (_dateFormat == null) {
      _dateFormat = new DateFormat.yMMMd();
      return _dateFormat;
    } else {
      return _dateFormat;
    }
  }

  static String printDuration(double hours) {
    Duration duration = Duration(seconds: (hours * 60 * 60).toInt());
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    return "[${twoDigits(duration.inHours)}h : $twoDigitMinutes m]";
  }
  static String convertSecondTo(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

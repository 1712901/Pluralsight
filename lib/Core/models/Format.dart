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
  static bool emailInvalid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (regex.hasMatch(email));
  }

  static bool passwordInvalid(String password) {
    Pattern pattern = r'^[A-Za-z0-9]{8,}$';
    RegExp regex = new RegExp(pattern);
    return (regex.hasMatch(password)) ;
  }

  static bool phoneInvalid(String phone) {
    Pattern pattern = r'[0-9]{10}$';
    RegExp regex = new RegExp(pattern);
    return (regex.hasMatch(phone));
  }
}

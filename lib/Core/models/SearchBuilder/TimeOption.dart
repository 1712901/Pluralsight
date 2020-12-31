import 'package:Pluralsight/Core/models/SearchMode.dart';

class TimeOption {
  static Map<String, Time> option = {
    "Từ 0 đến 5 giờ": Time(min: 0, max: 5),
    "Từ 5 đến 10 giờ": Time(min: 5, max: 10),
    "Từ 10 đến 20 giờ": Time(min: 10, max: 20),
    "Trên 20 giờ": Time(min: 20, max: null),
  };

}

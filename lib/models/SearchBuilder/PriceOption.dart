import 'package:Pluralsight/models/SearchMode.dart';

class PriceOption {
  static Map<String, Price> option = {
    "Miễn Phí": Price(min: 0, max: 0),
    "Dưới 200.000 đ": Price(min: 1, max: 200000),
    "Từ 200.000 đ đến 500.000 đ": Price(min: 200000, max: 500000),
    "Từ 500.000 đ đến 1 triệu": Price(min: 500000, max: 1000000),
    "Từ 1 triệu đ đến 2 triệu": Price(min: 1000000, max: 2000000),
    "Trên 2 triệu": Price(min: 2000000, max: null),
  };

}
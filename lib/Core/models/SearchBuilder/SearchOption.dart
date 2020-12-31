import 'package:Pluralsight/Core/models/SearchMode.dart';
import 'package:flutter/cupertino.dart';

class SearchOption extends ChangeNotifier {
  List<Time> _times = [];
  List<Price> _price = [];
  List<String> _category = [];

  List<Time> getTimes() {
    return this._times;
  }
  List<Price> getPrice() {
    return this._price;
  }
  List<String> getCategory() {
    return this._category;
  }

  void addTime({Time time}) {
    this._times.add(time);
    notifyListeners();
  }

  void addPrice({Price price}) {
    this._price.add(price);
    notifyListeners();
  }

  void addCategory({String categoryId}) {
    this._category.add(categoryId);
    notifyListeners();
  }

  void removePrice({Price price}) {
    this._price.remove(price);
    notifyListeners();
  }

  void removeTime({Time time}) {
    this._times.remove(time);
    notifyListeners();
  }

  void removeCategory({String categoryId}) {
    this._category.remove(categoryId);
    notifyListeners();
  }

  bool containsTime({Time time}) {
    return this._times.contains(time);
  }

  bool containsPrice({Price price}) {
    return this._price.contains(price);
  }

  bool containsCategory({String categoryId}) {
    return this._category.contains(categoryId);
  }

  void clearTime() {
    this._times.clear();
    notifyListeners();
  }

  void clearPrice() {
    this._price.clear();
    notifyListeners();
  }

  void clearCatgory() {
    this._category.clear();
    notifyListeners();
  }

  void clear() {
    this._category.clear();
    this._price.clear();
    this._times.clear();
    notifyListeners();
  }
}

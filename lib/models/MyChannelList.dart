import 'package:Pluralsight/models/MyChannel.dart';
import 'package:flutter/cupertino.dart';

class MyChannelListModel extends ChangeNotifier {
  final List<MyChannelModel> listChannel = [MyChannelModel('Android')];
  bool addMyChannel(String name) {
    listChannel.add(new MyChannelModel(name));
    notifyListeners();
    return true;
  }

  bool addCourse(int myChannelindex, int idCourse) {
    listChannel[myChannelindex].addCourse(idCourse);
    notifyListeners();
    return true;
  }

  void editChannel(MyChannelModel channel, String name) {
    int index = listChannel.indexOf(channel);
    listChannel[index].setName(name);
    notifyListeners();
  }

  void removeChannel(MyChannelModel channelModel) {
    listChannel.remove(channelModel);
    notifyListeners();
  }
}

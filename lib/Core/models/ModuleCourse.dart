class Module {
  String name;
  List<SubContent> contents = [];

  Module({this.name, this.contents});

  int getTotalTime() {
    int times = 0;
    for (int i = 0; i < contents.length; i++) {
      times += contents[i].time;
    }
    return times;
  }
}

class SubContent {
  String name;
  String url;
  int time;
  SubContent({this.name, this.url, this.time});
}

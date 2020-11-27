class MyChannelModel {
  String name;
  List<int> listIDCourse = [];
  MyChannelModel(this.name);
  bool addCourse(int idCourse) {
    if (!listIDCourse.contains(idCourse)) listIDCourse.add(idCourse);
  }

  void setName(String name) {
    this.name = name;
  }
}

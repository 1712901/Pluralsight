class MyChannelModel {
  String name;
  List<int> listIDCourse = [];
  MyChannelModel(this.name);
  bool addCourse(int idCourse) {
    if (!listIDCourse.contains(idCourse)) listIDCourse.add(idCourse);
    return true;
  }

  void setName(String name) {
    this.name = name;
  }

  void removeCourse(int id) {
    listIDCourse.remove(id);
  }
}

import 'package:Pluralsight/Page/CourseDetail.dart';
import 'package:Pluralsight/models/ModuleCourse.dart' as sub;

class CourseDetailModel {
  int id;
  String urlCurrent;
  String description;
  List<sub.Module> modules = [];
  CourseDetailModel({this.urlCurrent, this.description, this.modules, this.id});
}

class CourseDetailListModel {
  List<CourseDetailModel> courses = List.generate(
      10,
      (indexCourse) => new CourseDetailModel(
          urlCurrent: "http://course/id=${indexCourse}",
          id: indexCourse,
          description:
              "Otherwise, the widget has a child but no height, no width, no constraints, and no alignment, and the Container passes the constraints from the parent to the child and sizes itself to match the child.Otherwise, the widget has a child but no height, no width, no constraints, and no alignment, and the Container passes the constraints from the parent to the child and sizes itself to match the child.",
          modules: List.generate(
              4,
              (indexModule) => new sub.Module(
                  name: "Module ${indexModule}",
                  contents: List.generate(
                      4,
                      (index) => new sub.SubContent(
                          name: "Subcontent ${index}",
                          url:
                              'http://course/id=${indexCourse}/md=${indexModule}&&sub=${index}',
                          time: 100))))));

  CourseDetailModel getCourseDetail(int id) {
    return courses.firstWhere((element) => element.id == id);
  }
}

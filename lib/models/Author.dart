import 'dart:collection';

import 'package:Pluralsight/models/Course.dart';

class AuthorModel {
  int id;
  String name;
  String description;
  String link;
  List<int> courses = [];
  AuthorModel({this.id, this.name, this.description, this.link, this.courses});
}

class AuthorsModel {
  List<AuthorModel> authors = List.generate(
      10,
      (index) => new AuthorModel(
          id: index,
          name: "Author ${index}",
          description:
              "Otherwise, the widget has a child but no height, no width, no constraints, and no alignment, and the Container passes the constraints from the parent to the child and sizes itself to match the child.Otherwise, the widget has a child but no height, no width, no constraints, and no alignment, and the Container passes the constraints from the parent to the child and sizes itself to match the child.",
          courses:
              List.generate(3, (indexCourse) => (index * 2 + indexCourse) % 16),
          link: 'http://author/Author${index}'));
  List<AuthorModel> getAllAuthor(int idCourse) {
    return authors
        .where((element) => element.courses.contains(idCourse))
        .toList();
  }

  List<AuthorModel> getAllAuthorOfListCourse(List<CourseModel> list) {
    HashSet<AuthorModel> result = new HashSet();
    List<AuthorModel> find = [];
    for (int i = 0; i < list.length; i++) {
      find = authors
          .where((author) => author.courses.contains(list[i].ID))
          .toList();
      // for (int j = 0; j <= find.length; j++) {
      //   if (!result.contains(find[j])) {
      //     result.add(find[j]);
      //   }
      // }
      result.addAll(find);
    }
    return result.toList();
  }
}

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

@entity
class CourseEntity{
  @PrimaryKey(autoGenerate: true)
  int id;

  final String courseID;

  final String userID;

  CourseEntity({this.id, @required this.courseID,@required this.userID});
}
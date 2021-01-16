import 'package:Pluralsight/Core/models/DownLoad/Entity/Course.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
@Entity(
  tableName: 'LessonEntity',
  foreignKeys: [
    ForeignKey(childColumns: ['courseEntity_ID'], parentColumns: ['id'], entity: CourseEntity)
  ]
)
class LessonEntity{
  @PrimaryKey(autoGenerate:true)
  int id;

  final String lessonID;
  @ColumnInfo(name: 'courseEntity_ID')
  final int courseEntityID;
  final String path;

  LessonEntity({this.id,@required this.lessonID,@required this.courseEntityID,@required this.path});
}
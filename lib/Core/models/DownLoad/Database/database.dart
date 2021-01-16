import 'dart:async';

import 'package:Pluralsight/Core/models/DownLoad/DAO/CourseDAO.dart';
import 'package:Pluralsight/Core/models/DownLoad/DAO/LessonDAO.dart';
import 'package:Pluralsight/Core/models/DownLoad/Entity/Course.dart';
import 'package:Pluralsight/Core/models/DownLoad/Entity/Lesson.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 2, entities: [CourseEntity,LessonEntity])
abstract class App2Database extends FloorDatabase {
  CourseDAO get courseDAO;
  LessonDAO get lessonDAO;
}
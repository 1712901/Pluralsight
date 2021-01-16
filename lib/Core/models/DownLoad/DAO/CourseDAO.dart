import 'package:Pluralsight/Core/models/DownLoad/Entity/Course.dart';
import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
@dao
abstract class CourseDAO{
  @Query('SELECT * FROM CourseEntity WHERE userID=:userID')
  Future<List<CourseEntity>> findAllCourseByUserID(String userID);

  @Query('SELECT * FROM CourseEntity WHERE userID=:userID AND courseID=:courseID')
  Future<CourseEntity> findCourseEntity(String userID,String courseID);

  @insert
  Future<void> insertCourse(CourseEntity courseEntity);

  @Query('DELETE FROM CourseEntity WHERE userID=:userID AND courseID=:courseID')
  Future<void> deleteCourseOfUser(String userID, String courseID);

}
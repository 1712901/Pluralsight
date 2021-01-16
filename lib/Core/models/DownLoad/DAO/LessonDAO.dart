import 'package:Pluralsight/Core/models/DownLoad/Entity/Lesson.dart';
import 'package:floor/floor.dart';
@dao
abstract class LessonDAO{
  @Query('SELECT * FROM LessonEntity WHERE courseEntity_ID = :courseEntityID')
  Future<List<LessonEntity>> findLessonByCourseEntityID(int courseEntityID);

  @Query('SELECT * FROM LessonEntity WHERE lessonID = :lessonID AND courseEntity_ID = :courseEntityID')
  Future<LessonEntity> findLesson(String lessonID,int courseEntityID);

  @insert
  Future<void> insertLesson(LessonEntity lessonEntity);

  @Query('DELETE FROM LessonEntity WHERE courseEntity_ID=:courseEntityID')
  Future<void> deleteLessonOfCourse(int courseEntityID);
}
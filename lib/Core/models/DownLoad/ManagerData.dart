import 'package:Pluralsight/Core/models/DownLoad/Database/database.dart';
import 'package:Pluralsight/Core/models/DownLoad/Entity/Course.dart';
import 'package:Pluralsight/Core/models/DownLoad/Entity/Lesson.dart';

class ManagerData{
  static const  LOADED_LESSON=1;
  static const  NOT_LOADED_LESSON=-1;
  static const  LOADED_COURSE=0;
  App2Database _database ;
  Future<App2Database> openDatabase() async {
    _database=await $FloorApp2Database.databaseBuilder('app2_database.db').build();
    return _database;
  }
  void close(){
    _database.close();
  }
  Future<void> deleteCourse({String courseID,String userID}) async {
    CourseEntity courseEntity=await _database.courseDAO.findCourseEntity(userID, courseID);
    if(courseEntity!=null) {
      await _database.lessonDAO.deleteLessonOfCourse(courseEntity.id);
      await _database.courseDAO.deleteCourseOfUser(userID, courseID);
    }
  }

   Future<int> _isLoadedLesson({String courseID,String userID,String lessonID}) async {
    CourseEntity courseEntity=await _database.courseDAO.findCourseEntity(userID, courseID);
    if(courseEntity==null)
      return NOT_LOADED_LESSON;// Khóa học chưa được tải
    LessonEntity lessonEntity=await _database.lessonDAO.findLesson(lessonID,courseEntity.id);
    if(lessonEntity==null)
      return LOADED_COURSE;// Khóa học đã tải nhưng Lesson chưa đc tải
    return LOADED_LESSON; // Lesson đã tải được tải
  }
  Future<void> insertLessonCourse({String courseID,String userID,String lessonID,String path}) async {
    int loadedLesson=await _isLoadedLesson(courseID:courseID,userID:userID,lessonID:lessonID);
    switch(loadedLesson){
      case NOT_LOADED_LESSON:
        await _database.courseDAO.insertCourse(CourseEntity(courseID: courseID, userID: userID));
        break;
      case LOADED_LESSON:
        return;
      case LOADED_COURSE:
        break;
    }
    CourseEntity courseEntity=await _database.courseDAO.findCourseEntity(userID, courseID);
    await _database.lessonDAO.insertLesson(LessonEntity(lessonID: lessonID, courseEntityID: courseEntity.id,path: path));
  }
  Future<List<CourseEntity>> getAllCourses({String userID}) async {
    return  await _database.courseDAO.findAllCourseByUserID(userID);
  }
  Future<List<LessonEntity>> getAllLesson({int courseEntityID}) async {
    return  await _database.lessonDAO.findLessonByCourseEntityID(courseEntityID);
  }
  Future<LessonEntity> _getLessonEntity({String courseID,String userID,String lessonID}) async {
    CourseEntity courseEntity=await _database.courseDAO.findCourseEntity(userID, courseID);
    if(courseEntity==null)
      return null;// Khóa học chưa được tải
    LessonEntity lessonEntity=await _database.lessonDAO.findLesson(lessonID,courseEntity.id);
    return lessonEntity;
  }
  Future<String> getPathStore({String courseID,String userID,String lessonID}) async {
    LessonEntity lessonEntity=await this._getLessonEntity(courseID: courseID,userID: userID,lessonID: lessonID);
    if(lessonEntity==null) return null;
    return lessonEntity.path;
  }

  Future<bool> isLoadedLession({String courseID,String userID,String lessonID}) async {
    LessonEntity lessonEntity=await this._getLessonEntity(courseID: courseID,userID: userID,lessonID: lessonID);
    if(lessonEntity==null) return false;
    return true;
  }
}
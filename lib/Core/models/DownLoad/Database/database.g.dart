// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorApp2Database {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$App2DatabaseBuilder databaseBuilder(String name) =>
      _$App2DatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$App2DatabaseBuilder inMemoryDatabaseBuilder() =>
      _$App2DatabaseBuilder(null);
}

class _$App2DatabaseBuilder {
  _$App2DatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$App2DatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$App2DatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<App2Database> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$App2Database();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$App2Database extends App2Database {
  _$App2Database([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CourseDAO _courseDAOInstance;

  LessonDAO _lessonDAOInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CourseEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `courseID` TEXT, `userID` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `LessonEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `lessonID` TEXT, `courseEntity_ID` INTEGER, `path` TEXT, FOREIGN KEY (`courseEntity_ID`) REFERENCES `CourseEntity` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CourseDAO get courseDAO {
    return _courseDAOInstance ??= _$CourseDAO(database, changeListener);
  }

  @override
  LessonDAO get lessonDAO {
    return _lessonDAOInstance ??= _$LessonDAO(database, changeListener);
  }
}

class _$CourseDAO extends CourseDAO {
  _$CourseDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _courseEntityInsertionAdapter = InsertionAdapter(
            database,
            'CourseEntity',
            (CourseEntity item) => <String, dynamic>{
                  'id': item.id,
                  'courseID': item.courseID,
                  'userID': item.userID
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CourseEntity> _courseEntityInsertionAdapter;

  @override
  Future<List<CourseEntity>> findAllCourseByUserID(String userID) async {
    return _queryAdapter.queryList('SELECT * FROM CourseEntity WHERE userID=?',
        arguments: <dynamic>[userID],
        mapper: (Map<String, dynamic> row) => CourseEntity(
            id: row['id'] as int,
            courseID: row['courseID'] as String,
            userID: row['userID'] as String));
  }

  @override
  Future<CourseEntity> findCourseEntity(String userID, String courseID) async {
    return _queryAdapter.query(
        'SELECT * FROM CourseEntity WHERE userID=? AND courseID=?',
        arguments: <dynamic>[userID, courseID],
        mapper: (Map<String, dynamic> row) => CourseEntity(
            id: row['id'] as int,
            courseID: row['courseID'] as String,
            userID: row['userID'] as String));
  }

  @override
  Future<void> deleteCourseOfUser(String userID, String courseID) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM CourseEntity WHERE userID=? AND courseID=?',
        arguments: <dynamic>[userID, courseID]);
  }

  @override
  Future<void> insertCourse(CourseEntity courseEntity) async {
    await _courseEntityInsertionAdapter.insert(
        courseEntity, OnConflictStrategy.abort);
  }
}

class _$LessonDAO extends LessonDAO {
  _$LessonDAO(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _lessonEntityInsertionAdapter = InsertionAdapter(
            database,
            'LessonEntity',
            (LessonEntity item) => <String, dynamic>{
                  'id': item.id,
                  'lessonID': item.lessonID,
                  'courseEntity_ID': item.courseEntityID,
                  'path': item.path
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LessonEntity> _lessonEntityInsertionAdapter;

  @override
  Future<List<LessonEntity>> findLessonByCourseEntityID(
      int courseEntityID) async {
    return _queryAdapter.queryList(
        'SELECT * FROM LessonEntity WHERE courseEntity_ID = ?',
        arguments: <dynamic>[courseEntityID],
        mapper: (Map<String, dynamic> row) => LessonEntity(
            id: row['id'] as int,
            lessonID: row['lessonID'] as String,
            courseEntityID: row['courseEntity_ID'] as int,
            path: row['path'] as String));
  }

  @override
  Future<LessonEntity> findLesson(String lessonID, int courseEntityID) async {
    return _queryAdapter.query(
        'SELECT * FROM LessonEntity WHERE lessonID = ? AND courseEntity_ID = ?',
        arguments: <dynamic>[lessonID, courseEntityID],
        mapper: (Map<String, dynamic> row) => LessonEntity(
            id: row['id'] as int,
            lessonID: row['lessonID'] as String,
            courseEntityID: row['courseEntity_ID'] as int,
            path: row['path'] as String));
  }

  @override
  Future<void> deleteLessonOfCourse(int courseEntityID) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM LessonEntity WHERE courseEntity_ID=?',
        arguments: <dynamic>[courseEntityID]);
  }

  @override
  Future<void> insertLesson(LessonEntity lessonEntity) async {
    await _lessonEntityInsertionAdapter.insert(
        lessonEntity, OnConflictStrategy.abort);
  }
}

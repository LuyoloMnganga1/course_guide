import 'package:sqflite/sqflite.dart';
import 'package:course_guide/Models/course.dart';

class courseDBHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "courses";

  static Future<void> initDb() async{
    if(_db!=null) {
      return;
    }else{
      try {
        String _path = await getDatabasesPath() + "courses.db";
        _db = await openDatabase(
            _path,
            version: _version,
            onCreate: (db, version) {
              return db.execute(
                "CREATE TABLE $_tableName("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    "name STRING, description TEXT, "
                    "point INTEGER, color INTEGER)",
              );
            }
        );
      }catch(e){
        print(e);
      }
    }

  }
  static Future<int> insert(Course? course) async{
    return await _db?.insert(_tableName, course!.toJson())??1;
  }
  static Future<List<Map<String, dynamic>>> query() async{
    return await _db!.query(_tableName);
  }
  static Future<List<Map<String, dynamic>>> search(int points) async{
    return await _db!.query(_tableName,where: 'point <= ?',whereArgs: [points]);
  }
  static delete(Course course) async {
    return await _db!.delete(_tableName,where: 'id=?',whereArgs: [course.id]);
  }

  static Future<int> subjectUpdate (Course? course) async{
    return await _db!.update(_tableName, course!.toJson(),where: 'id=?',whereArgs: [course.id]);
  }
}
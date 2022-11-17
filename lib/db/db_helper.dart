import 'package:sqflite/sqflite.dart';
import 'package:course_guide/Models/subject.dart';

class DBHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "subjects";

  static Future<void> initDb() async{
    if(_db!=null) {
      return;
    }else{
      try {
        String _path = await getDatabasesPath() + "subjects.db";
        _db = await openDatabase(
            _path,
            version: _version,
            onCreate: (db, version) {
              return db.execute(
                "CREATE TABLE $_tableName("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    "name STRING, percent STRING, date STRING, "
                    "point INTEGER, color INTEGER)",
              );
            }
        );
      }catch(e){
        print(e);
      }
    }

  }
    static Future<int> insert(Subject? subject) async{
    return await _db?.insert(_tableName, subject!.toJson())??1;
  }
  static Future<List<Map<String, Object?>>?> calculatePoints() async{
    return await _db?.rawQuery('''
        SELECT sum(point)  FROM subjects
        ''');
  }
  static Future<List<Map<String, dynamic>>> query() async{
    return await _db!.query(_tableName);
  }
  static Future<List<Map<String, dynamic>>> search(String name) async{
    return await _db!.query(_tableName,where: 'name=?',whereArgs: [name]);
  }
  static delete(Subject subject) async {
    return await _db!.delete(_tableName,where: 'id=?',whereArgs: [subject.id]);
  }

  static Future<int> subjectUpdate (Subject? subject) async{
    return await _db!.update(_tableName, subject!.toJson(),where: 'id=?',whereArgs: [subject.id]);
  }
}
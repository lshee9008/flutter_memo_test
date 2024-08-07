import 'package:memo_test/models/memo_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<void> initDatabase() async {
    if (_database == null) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'memos.db');

      _database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('''
          CREATE TABLE memos(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            content TEXT,
            createAt TEXT
          )
        ''');
      });
    }
  }

  Future<List<MemoData>> getMemos() async {
    await initDatabase();
    List<Map<String, dynamic>> maps = await _database!.query('memos');

    return List.generate(maps.length, (index) {
      return MemoData(
          id: maps[index][
              'id'], //설명 하자면은 maps가 List<Map<String, dynamic>> 의 자료형이므로 여기서 index는 List의 index값이 되는 거고
          // 'id'는 Map 자료형의 String이 된다 이렇게 검색한 데이터는 content (String) 혹은 createAt (DateTime))이 될수 있으니 Dynamic으로 구현
          content: maps[index]['content'],
          createAt: DateTime.parse(maps[index]['createAt']));
    });
  }
}

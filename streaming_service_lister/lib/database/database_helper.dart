
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;



// class DatabaseHelper {

//   static final _databaseName = 'MyLocalDatabase.db';
//   static final _databaseVersion = 1;

//   static final table = 'my_table';

//   static final columnId = 'id';
//   static final columnName = 'name';

// }

// class DatabaseHelper {
//   DatabaseHelper._privateConstructor();
//   static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
//   static Database? _database;
//   Future<Database> get database async => _database ??= await _initDatabase();

//   Future<Database> 

// }



// https://www.kindacode.com/article/flutter-sqlite/
class SQLHelper {

  // id: the id of a item
  // title, description: name and description of your activity
  // created_at: the time that the item was created. It will be automatically handled by SQLite
  static Future<void> createTables(sql.Database database) async {
    //await database.execute("DROP TABLE IF EXISTS items");
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'my_list.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item
  static Future<int> createItem(String title) async {
    final db = await SQLHelper.db();

    final data = {'title': title};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: "id");
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      print("Something went wrong when deleting an item: $err");
    }
  }

}
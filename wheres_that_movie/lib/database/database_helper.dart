// database_helper.dart
// Author: Samuel Rudqvist
// Date Created: Unknown
//
// Purpose:
//    The database helper creates the database when the app is
//    started the first time and has methods for adding, getting,
//    and deleting items.
//
// Modification Log:
//    (03/07/2023)(SR): Removed dead code.
//

import 'package:sqflite/sqflite.dart' as sql;

// https://www.kindacode.com/article/flutter-sqlite/
class SQLHelper {
  // id: the id of a item
  // title, description: name and description of your activity
  // created_at: the time that the item was created. It will be automatically handled by SQLite
  static Future<void> createTables(sql.Database database) async {
    //await database.execute("DROP TABLE IF EXISTS items");
    await database.execute("""CREATE TABLE movies(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        movieId INTEGER NOT NULL,
        movieTitle STRING,
        movieImgPath STRING,
        isMovie INTEGER,
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
  static Future<int> createItem(
      int movieId, String movieTitle, String movieImgPath, int isMovie) async {
    final db = await SQLHelper.db();

    final data = {
      'movieId': movieId,
      'movieTitle': movieTitle,
      'movieImgPath': movieImgPath,
      'isMovie': isMovie,
    };
    final id = await db.insert('movies', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items
  static Future<List<Map<String, dynamic>>> getMovies() async {
    final db = await SQLHelper.db();
    return db.query('movies', orderBy: "id");
  }

  // Check if item is in the db
  static Future<bool> checkItem(int movieId) async {
    final db = await SQLHelper.db();
    bool itemExists = false;
    final result =
        await db.query("movies", where: "movieId = ?", whereArgs: [movieId]);
    if (result.isNotEmpty) {
      itemExists = true;
    }
    return itemExists;
  }

  static Future<List<Map<String, dynamic>>> getItem(int movieId) async {
    final db = await SQLHelper.db();
    return await db.query("movies", where: "movieId = ?", whereArgs: [movieId]);
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("movies", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      // print error message here
    }
  }
}

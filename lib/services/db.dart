import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pickamovie/models/movie.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final _databaseName = "movies.db";
  static final tagsPreferenceTable = 'TagsRate';
  static final movieTable = 'Movies';
  static final tagMovieTable = 'TagToMovie';
  Db();

  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    await _database.execute(
        'CREATE TABLE IF NOT EXISTS TagMetrics (id INTEGER PRIMARY KEY, rate INTEGER default  0, views INTEGER default 0);');
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);

// Only copy if the database doesn't exist
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      // Load database from asset and copy
      ByteData data = await rootBundle.load(join('assets', 'movies.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      // Save copied asset to documents
      await new File(path).writeAsBytes(bytes);
    }
    return await openDatabase(path);
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<List<Movie>> queryMoviesFromTags(
      List<int> tagIds) /*, int topK)*/ async {
    String queryParams(int n) {
      String res = "?";
      for (int i = 1; i < n; i++) {
        res += ", ?";
      }
      return res;
    }

    Database db = await database;
    Set<int> res = {};
    for (int i = 0; i < tagIds.length; i++) {
      Set<int> mov = Set.from((await db.query(
        tagMovieTable,
        distinct: true,
        columns: ["movieId"],
        where: "tagId = ?",
        whereArgs: [tagIds[i]],
      ))
          .map((e) => e["movieId"])
          .toList());
      if (i == 0) {
        res = res.union(mov);
      } else {
        res = res.intersection(mov);
      }
    }
    List<int> movieIds = res.toList();

    String movieNumber = queryParams(movieIds.length);
    List<Map> movies = await db.query(
      movieTable,
      distinct: true,
      where: "movieId IN ($movieNumber)",
      orderBy: "rating DESC",
      limit: 100,
      whereArgs: movieIds,
    );
    return movies.map((e) => Movie.fromSql(e)).toList();
  }

  Future<List<Map>> getTagRate(List<int> tagIds) async {
    Database db = await database;
    String queryParams(int n) {
      String res = "?";
      for (int i = 1; i < n; i++) {
        res += ", ?";
      }
      return res;
    }

    String params = queryParams(tagIds.length);
    return db.query(tagsPreferenceTable,
        distinct: true,
        where: "id in ($params)",
        whereArgs: tagIds,
        orderBy: "rate DESC");
  }

  void setTagRate(int id, int rate) async {
    Database db = await database;

    await db.execute(
        "REPLACE INTO $tagsPreferenceTable (id, rate) VALUES($id, $rate)");
  }
/*
  void setTagsRate(List <int> ids, List <int> rates) async {
    Database db = await database;
    await db.execute(
        "REPLACE INTO $tagsPreferenceTable (id, rate) VALUES($id, $rate)");
  }
*/

}

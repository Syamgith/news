import 'dart:io';

import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache {
  Database db;
  NewsDbProvider() {
    init();
  }
  Future<List<int>> fetchTopIds() {
    return null;
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) async {
        await newDb.execute('''
        CREATE TABLE items (
          id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleted INTEGER,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER
        )
        ''');
      },
    );
  }

  Future<ItemModel> fetchItem(int id) async {
    final map = await db.query(
      "items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if (map.length > 0) {
      return ItemModel.fromDb(map.first);
    }
    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert("items", item.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> clear() {
    return db.delete('items');
  }
}

final newsDbProvider = NewsDbProvider();

import 'dart:async';
import 'dart:io';

import 'repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/item.dart';

class NewsDbProvider implements Source {
  late Database db;
  String itemsTable = "Items";
  String sqlCreateItemsTable = """
    CREATE TABLE Items
        (
          id INTEGER PRIMARY KEY,
          type TEXT,
          by TEXT,
          time TEXT,
          parent INTEGER,
          parent INTEGER,
          kids BLOB,
          dead INTEGER,
          deleted INTGER,
          url TEXT,
          score INTEGER,
          title TEXT,
          descendants INTEGER
        )
  """;

  // Todo - store and fetch top ids
  @override
  Future<List<int>> fetchTopIds() {
    // ignore: null_check_always_fails
    return null!;
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute(sqlCreateItemsTable);
    });
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db
        .query(itemsTable, columns: null, where: 'id = ?', whereArgs: [id]);

    // ignore: prefer_is_empty, its an array for sure.
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    // ignore: null_check_always_fails
    return null!; // explicit return null
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(itemsTable, item.toMapForDb());
  }
}
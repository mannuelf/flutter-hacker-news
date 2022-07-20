import 'package:newz/src/models/item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import '../models/item.dart';

class NewsDbProvider {
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

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute(sqlCreateItemsTable);
    });
  }

  fetchItem(int id) async {
    final maps = await db
        .query(itemsTable, columns: null, where: 'id = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  addItem(ItemModel item) {
    return db.insert(itemsTable, item.toMapForDb());
  }
}

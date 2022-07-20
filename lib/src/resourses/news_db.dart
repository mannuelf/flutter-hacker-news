import 'package:newz/src/models/item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import '../models/item.dart';

class NewsDbProvider {
  late Database db;
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
    db.query('Items', columns: null, where: 'id = ?', whereArgs: [id]);
  }
}

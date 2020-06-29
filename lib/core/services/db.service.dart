import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shoppingappsampleflutter/core/models/app_config.dart';
import 'dart:math' as Math;

class DbService {
  Future<Database> _database;
  final int instanceId = Math.Random().nextInt(10000);

  DbService() {
    print(
        "DbService $instanceId _______________________________________________");
    initDb();
  }

  Future<Database> waitDbInit() async {
    var database = await _database;

    while (database == null) {
      await Future.delayed(Duration(milliseconds: 50));
      print(
          "DbService $instanceId _______________________________________________");

      database = await _database;
    }
    return database;
  }

  void initDb() async {
    // Open the database and store the reference.
    var dbRootPath = await getDatabasesPath();
    var dbPath = join(dbRootPath, 'shoppingappsample_flutter_database2.db');
    print(
        "dbPath $dbPath  $instanceId _______________________________________________");
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      dbPath,
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        print("DB.ONCREATE _______________________________________________");
        db.execute(
          "CREATE TABLE ${AppConfig().tableName} (id INTEGER PRIMARY KEY, key TEXT, value TEXT);",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    this._database = database;
  }

  getAllTable(String tableName) async {
    final db = await waitDbInit();
    print(
        "getAllTable  $instanceId _______________________________________________");
    return db.query(tableName);
  }

  Future<int> insert(String tableName, Map map) async {
    final db = await waitDbInit();
    print(
        "getAllTable  $instanceId _______________________________________________");

    return db.insert(
      tableName,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _dbName = 'myDB.db';
  static const _dbVersion = 1;
  static const _tableName = 'myTable';

  static const columnId = '_id';
  static const columnName = 'name';
  static const columnEmail = 'email';
  static const columnAddress = 'address';
  static const columnPhone = 'phone';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initiateDatabase();
    return _database!;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future? _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE $_tableName ( 
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT NOT NULL,
      $columnEmail TEXT NOT NULL,
      $columnAddress TEXT NOT NULL,
      $columnPhone TEXT NOT NULL )
      ''');
  }

  Future<int?> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(_tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(_tableName);
  }

  Future<int?> delete(int? id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<bool> deleteDb() async {
    bool databaseDeleted = false;

    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _dbName);
      await deleteDatabase(path).whenComplete(() {
        databaseDeleted = true;
      }).catchError((onError) {
        databaseDeleted = false;
      });
    } on DatabaseException catch (error) {
      //print(error);
    } catch (error) {
      //print(error);
    }

    return databaseDeleted;
  }
}

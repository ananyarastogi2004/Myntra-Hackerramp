import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "mini_dataset.db");

    // Check if the database exists
    bool exists = await databaseExists(path);

    if (!exists) {
      // Copy from asset
      ByteData data = await rootBundle.load(join('assets', 'mini_dataset.db'));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getProductsByColors(List<String> colors) async {
    Database db = await instance.database;
    String colorFilter = colors.map((color) => "'$color'").join(", ");
    return await db.query('products', where: 'colour IN ($colorFilter)');
  }
}

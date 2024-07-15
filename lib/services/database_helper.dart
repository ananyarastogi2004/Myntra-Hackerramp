// lib/services/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import '../models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'products1.db');

    // Check if the database already exists
    final exists = await databaseExists(path);

    if (!exists) {
      // If the database does not exist, copy it from the assets
      try {
        await Directory(dirname(path)).create(recursive: true);

        // Copy from assets
        ByteData data = await rootBundle.load(join('assets', 'products1.db'));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        await File(path).writeAsBytes(bytes, flush: true);
      } catch (e) {
        print("Error copying database: $e");
      }
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // This is left empty as you have already created the database
      },
    );
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.rawQuery('SELECT * FROM products1 ORDER BY RANDOM()');
    List<Product> products = [];
    for (var map in maps) {
      // Check for null values and skip if any field is null
      if (map.values.any((value) => value == null)) {
        continue;
      }
      products.add(Product.fromMap(map));
    }
    return products;
  }
}

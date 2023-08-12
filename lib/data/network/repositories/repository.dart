// ignore_for_file: depend_on_referenced_packages

import 'package:login_screen_homework/data/models/map/map_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late Database _database;

  static Future<void> initializeDatabase() async {
    _database = await openDatabase(
      'addresses.db',
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE addresses (
          id INTEGER PRIMARY KEY,
          name TEXT,
          latitude REAL,
          longitude REAL,
          address TEXT
        )
      ''');
      },
    );
  }


  static Future<void> insertAddress(Address address) async {
    await _database.insert('addresses', {
      'name': address.name,
      'address': address.address,
    });
  }

  static Future<List<Address>> getAddresses() async {
    final db = _database;
    final List<Map<String, dynamic>> maps = await db.query('addresses');

    return List.generate(maps.length, (i) {
      return Address(
        id: maps[i]['id'],
        name: maps[i]['name'],
        address: maps[i]['address'],
      );
    });
  }


  static Future<void> deleteAddress(int id) async {
    final db = _database;
    await db.delete('addresses', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteAllAddresses() async {
    final db = _database;
    await db.delete('addresses');
  }
}

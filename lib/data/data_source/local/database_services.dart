// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices {
  late Database _database;

  DatabaseServices() {
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      // Get the directory for storing databases.
      final String databasesPath = await getDatabasesPath();
      final String path = join(databasesPath, 'example_database.db');

      // Open the database. Creates if it doesn't exist.
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: _onCreate,
      );

      log('Database initialized successfully');
    } catch (e) {
      log('Error initializing database: $e');
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create tables if they don't exist
    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS movie_bookings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        time TEXT,
        movie_id INTEGER,
        movie_image TEXT,
        ticket_number TEXT,
        cinema_id INTEGER,
        seat_numbers TEXT,
        created_at TEXT,
        updated_at TEXT
      )
      ''',
    );

    log('Database tables created');
  }

  Future<List<Map<String, dynamic>>?> customQuery(String query) async {
    try {
      final List<Map<String, dynamic>> result = await _database.query(query);
      log('Custom query executed successfully');
      return result;
    } catch (e) {
      log('Error executing custom query: $e');
      return null;
    }
  }

  Future<int?> insertData(String table, Map<String, dynamic> data) async {
    try {
      final int id = await _database.insert(table, data);
      log('Data inserted successfully');
      return id;
    } catch (e) {
      log('Error inserting data: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> fetchData(String table) async {
    try {
      final List<Map<String, dynamic>> result = await _database.query(table);
      log('Data fetched successfully');
      return result;
    } catch (e) {
      log('Error fetching data: $e');
      return null;
    }
  }

  Future<int?> updateData(
      String table, Map<String, dynamic> data, int id) async {
    try {
      final int rowsAffected =
          await _database.update(table, data, where: 'id = ?', whereArgs: [id]);
      log('Data updated successfully');
      return rowsAffected;
    } catch (e) {
      log('Error updating data: $e');
      return null;
    }
  }

  Future<int?> deleteData(String table, int id) async {
    try {
      final int rowsAffected =
          await _database.delete(table, where: 'id = ?', whereArgs: [id]);
      log('Data deleted successfully');
      return rowsAffected;
    } catch (e) {
      log('Error deleting data: $e');
      return null;
    }
  }
}

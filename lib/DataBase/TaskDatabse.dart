import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

import '../Controller/TaskController.dart';
import '../Model/Task.dart';

class DBHelper {
  static Database? _database;
  static final DBHelper instance = DBHelper._();

  DBHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks("
              "id TEXT PRIMARY KEY,"
              "title TEXT,"
              "description TEXT,"
              "schedule TEXT,"
              "missed INTEGER,"
              "completed INTEGER,"
              "createdAt INTEGER,"
              "dueDate INTEGER,"
              "priority TEXT"
              ")",
        );
      },
      version: 1,
    );
  }

  Future<Task> insertTask(Task task) async {
    final db = await database;
    task.id = (await db.insert('tasks', task.toMap())) as String;
    return task;
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        schedule: maps[i]['schedule'],
        missed: maps[i]['missed'] == 1,
        completed: maps[i]['completed'] == 1,
        createdAt: DateTime.fromMillisecondsSinceEpoch(maps[i]['createdAt']),
        dueDate: maps[i]['dueDate'] != null
            ? DateTime.fromMillisecondsSinceEpoch(maps[i]['dueDate'])
            : null,
        priority: maps[i]['priority'],
      );
    });
  }

  Future<int> updateTask(Task task) async {
    final db = await database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: "id = ?",
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(String id) async {
    final db = await database;
    return await db.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

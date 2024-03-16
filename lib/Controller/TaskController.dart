import 'dart:math';

import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Task {
  late String id;
  final String title;
  final String description;
  final String schedule;
  late bool missed;
  late bool completed;
  final DateTime createdAt;

  // Optional fields
  final DateTime? dueDate;
  final String? priority;

  Task({
    this.id = '',
    required this.title,
    this.description = '',
    this.completed = false,
    this.missed = false,
    required this.createdAt,
    this.dueDate,
    this.priority,
    required this.schedule,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? completed,
    bool? missed,
    DateTime? createdAt,
    DateTime? dueDate,
    String? priority,
    String? schedule,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      missed: missed ?? this.missed,
      schedule: schedule ?? this.schedule,
    );
  }

  // Replace with a custom implementation if needed
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Task &&
              id == other.id &&
              title == other.title &&
              description == other.description &&
              completed == other.completed &&
              missed == other.missed &&
              createdAt == other.createdAt &&
              dueDate == other.dueDate &&
              priority == other.priority;

  @override
  int get hashCode =>
      hashValues([
        id,
        title,
        description,
        completed,
        createdAt,
        dueDate,
        priority,
        missed,
      ], hashCode);

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, completed: $completed, createdAt: $createdAt, dueDate: $dueDate, priority: $priority ,missed:$missed}';
  }

  Map<String, dynamic> toMap() {
    return {
      'schedule': schedule,
      'id': id,
      'title': title,
      'description': description ?? '',
      'completed': completed ? 1 : 0,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'priority': priority,
      'missed': missed ? 1 : 0,
    };
  }

  Task.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        title = map['title'] as String,
        description = map['description'] as String? ?? '',
        completed = (map['completed'] as int) == 1,
        createdAt =
        DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
        dueDate = map['dueDate']?.toInt() != null
            ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int)
            : null,
        missed = (map['missed'] as int) == 1,
        schedule = map['schedule'] as String,
        priority = map['priority'] as String?;
}

class TaskController extends GetxController {
  late Database _database;
  RxList<Task> totalTask = <Task>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeDatabase();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final tasks = await getAllTasks();
    totalTask.assignAll(tasks);
  }
  void _initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'tasks.db'),
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

  Future<void> insertTask(Task task) async {
    var random = Random();
    var id = List.generate(10, (_) => random.nextInt(10)).join();
   try{
       var uuid = Uuid();
       task.id = uuid.v4(); // Generate a unique UUID for the task
       await _database.insert('tasks', task.toMap());
   }catch(e){
     print(e.toString());
   }
    fetchTasks();
    update();
  }


  Future<List<Task>> getAllTasks() async {
    final List<Map<String, dynamic>> maps = await _database.query('tasks');
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

  Future<void> updateTask(String id) async {
    final task = await _database.query('tasks', where: "id = ?", whereArgs: [id]);
    if (task.isNotEmpty) {
      final updatedTask = Task.fromMap(task.first);
      updatedTask.completed = true;
      await _database.update(
        'tasks',
        updatedTask.toMap(),
        where: "id = ?",
        whereArgs: [id],
      );
      fetchTasks();
      update();
    } else {
      throw Exception('Task with ID $id not found');
    }
  }


  Future<void> deleteTask(String id) async {
    await _database.delete(
      'tasks',
      where: "id = ?",
      whereArgs: [id],
    );
    fetchTasks();
    update();
  }
}

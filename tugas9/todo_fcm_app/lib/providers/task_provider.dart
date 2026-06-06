import 'package:flutter/material.dart';

class TaskItem {
  final String title;
  bool isDone;

  TaskItem({required this.title, this.isDone = false});
}

class TaskProvider with ChangeNotifier {
  final List<TaskItem> _tasks = [];

  List<TaskItem> get tasks => _tasks;

  void addTask(String title) {
    if (title.isNotEmpty) {
      _tasks.add(TaskItem(title: title));
      notifyListeners();
    }
  }

  void toggleTaskStatus(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].isDone = !_tasks[index].isDone;
      notifyListeners();
    }
  }

  void clearTasks() {
    _tasks.clear();
    notifyListeners();
  }
}

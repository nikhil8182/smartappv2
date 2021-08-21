import 'package:flutter/material.dart';
import 'data.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier{
  List<Task> _tasks = [

  ];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount{
    return _tasks.length;
  }
  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle,);
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(Task task){
    _tasks.remove(task);
    notifyListeners();
  }

}

import 'package:flutter/material.dart';
import 'package:task_management_frontend/models/task.dart';
import 'package:task_management_frontend/service/task_network_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];
  TaskProvider(){
    fetchTasks();
  }

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _taskService.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _taskService.createTask(task);
    await fetchTasks();
  }

  Future<void> deleteTask(String taskId) async {
    await _taskService.deleteTask(taskId);
    await fetchTasks();
  }

  Future<void> updateTask(String taskId, Task task) async {
    await _taskService.updateTask(taskId, task);
    await fetchTasks();
  }
}

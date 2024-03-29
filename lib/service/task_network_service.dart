import 'package:dio/dio.dart';
import 'package:task_management_frontend/models/task.dart';

class TaskService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://taskmanagementbackend-production-fa62.up.railway.app/api'));

  Future<List<Task>> fetchTasks() async {
    try {
      final response = await _dio.get('/tasks');
      List<Task> tasks = (response.data as List)
          .map((json) => Task.fromJson(json))
          .toList();
      return tasks;
    } catch (error) {
      throw Exception('Failed to fetch tasks');
    }
  }

  Future<Task> createTask(Task task) async {
    try {
      final response = await _dio.post(
        '/tasks',
        data: {
          'title': task.title,
          'description': task.description,
          'status': task.status,
        },
      );
      return Task.fromJson(response.data);
    } catch (error) {
      print('Error creating task: $error');
      throw Exception('Failed to create task');
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _dio.delete('/tasks/$taskId');
    } catch (error) {
      print('Error deleting task: $error');
      throw Exception('Failed to delete task');
    }
  }

  Future<Task> updateTask(String taskId, Task task) async {
    try {
      final response = await _dio.patch(
        '/tasks/$taskId',
        data: {
          'title': task.title,
          'description': task.description,
          'status': task.status,
        },
      );
      return Task.fromJson(response.data);
    } catch (error) {
      print('Error updating task: $error');
      throw Exception('Failed to update task');
    }
  }
}


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_frontend/models/task.dart';
import 'package:task_management_frontend/ui/update_task_screen.dart';
import 'package:task_management_frontend/vm/task_provider.dart';

import 'add_task.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, _) {
          if (taskProvider.tasks.isEmpty) {
            return Center(
              child: Text('No tasks available.'),
            );
          } else {
            return ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                 Task task = taskProvider.tasks[index];
                return ListTile(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateTaskScreen(task: task)),
                    );
                  },
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: DropdownButton<String>(
                    value: task.status,
                    onChanged: (String? newValue) {
                      // Implement update task status logic
                      if (newValue != null) {
                        task.status=newValue;
                        Provider.of<TaskProvider>(context, listen: false)
                            .updateTask(task.id, task);
                      }
                    },
                    items: <String>['To Do', 'In Progress', 'Done']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  onLongPress: () async{
                    bool deleteConfirmed = await _showDeleteConfirmationDialog(context);
                    if (deleteConfirmed) {
                      // Implement delete task logic
                      Provider.of<TaskProvider>(context, listen: false)
                          .deleteTask(task.id);
                    }
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if cancel is clicked
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if delete is clicked
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

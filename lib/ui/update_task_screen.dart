import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_frontend/models/task.dart';
import 'package:task_management_frontend/vm/task_provider.dart';

class UpdateTaskScreen extends StatelessWidget {
  final Task task;

  UpdateTaskScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController =
    TextEditingController(text: task.title);
    final TextEditingController _descriptionController =
    TextEditingController(text: task.description);

    String _status = task.status;

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _status,
              onChanged: (String? newValue) {
                _status = newValue!;
              },
              items: <String>['To Do', 'In Progress', 'Done']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Status'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                Task updatedTask = Task(
                  id: task.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  status: _status,
                );
                await Provider.of<TaskProvider>(context, listen: false)
                    .updateTask(task.id, updatedTask);
                Navigator.pop(context);
              },
              child: Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}

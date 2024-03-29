import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_frontend/models/task.dart';
import 'package:task_management_frontend/vm/task_provider.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: AddTaskForm(),
    );
  }
}

class AddTaskForm extends StatefulWidget {
  @override
  _AddTaskFormState createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _status = 'To Do';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: _status,
            onChanged: (String? newValue) {
              setState(() {
                _status = newValue!;
              });
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
              Task task = Task(
                id: '', // Generate unique id or set to empty string
                title: _titleController.text,
                description: _descriptionController.text,
                status: _status,
              );
              await Provider.of<TaskProvider>(context, listen: false).addTask(task);
              Navigator.pop(context);
            },
            child: Text('Add Task'),
          ),
        ],
      ),
    );
  }
}

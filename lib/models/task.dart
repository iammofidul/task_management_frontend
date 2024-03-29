// task_model.dart
class Task {
   String id;
   String title;
   String description;
   String status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id']??"",
      title: json['title']??"",
      description: json['description']??"",
      status: json['status']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }
}

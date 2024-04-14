import 'dart:convert';

class Task {
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
  
    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(int.parse(map['createdAt'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
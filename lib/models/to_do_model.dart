import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoModel {
  final String id;
  final String title;
  final bool isDone;
  final String userId;
  final DateTime? dueDate;

  ToDoModel({
    required this.id,
    required this.title,
    required this.isDone,
    required this.userId,
    this.dueDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isDone': isDone,
      'userId': userId,
      'dueDate': dueDate,
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ToDoModel(
      id: documentId,
      title: map['title'],
      isDone: map['isDone'] ?? false,
      userId: map['userId'] ?? '',
      dueDate: map['dueDate'] != null
          ? (map['dueDate'] as Timestamp).toDate()
          : null,
    );
  }
}

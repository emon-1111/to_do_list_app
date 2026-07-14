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

  //Takes in raw data from Firestore — a map (the fields) and documentId (the folder name/ID, stored separately).
  //Pulls out each value from the map — title, isDone, userId, dueDate — using ?? to fall back to a safe default if any value is missing.
  //Builds and returns a real ToDoModel object using those values.

  factory ToDoModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ToDoModel(
      id: documentId,
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
      userId: map['userId'] ?? '',
      dueDate: map['dueDate'] != null
          ? (map['dueDate'] as Timestamp).toDate()
          : null,
    );
  }
}

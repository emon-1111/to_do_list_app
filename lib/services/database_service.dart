import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app/models/to_do_model.dart';

class DatabaseService {
  final String? uid;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  DatabaseService({this.uid});

  CollectionReference get todosCollectiona {
    return _db.collection('todoApp').doc(uid).collection('todos');
  }

  //CREATE TODOS
  Future<void> addTodo(String title, DateTime? dueDate) async {
    if (uid == null) return;
    await todosCollectiona.add({
      'title': title,
      'isDone': false,
      'userId': uid,
      'createdAt': FieldValue.serverTimestamp(),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate) : null,
    });
  }

  //update todo
  Future<void> updateTodoStatus(String id, bool isDone) async {
    await todosCollectiona.doc(id).update({'isDone': isDone});
  }

  //Edit todo
  Future<void> updateTodo(String id, String title, DateTime? dueDate) async {
    await todosCollectiona.doc(id).update({
      'title': title,
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate) : null,
    });
  }

  //delete todo
  Future<void> deleteTodo(String id) async {
    await todosCollectiona.doc(id).delete();
  }

  //read ALL todos

  Stream<List<ToDoModel>> get todos {
    if (uid == null) {
      return Stream.value([]);
    }
    return todosCollectiona
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(_todoListFormSnapshot);
  }

  List<ToDoModel> _todoListFormSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ToDoModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}

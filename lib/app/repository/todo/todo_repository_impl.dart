import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/app/model/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late SharedPreferences prefs;

  @override
  Future<List<TodoModel>> getAll() async {
    List<TodoModel> todos = [];
    prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("USER_ID");

    await db
        .collection("todos")
        .where("user_id", isEqualTo: userId)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        todos.add(TodoModel.fromMap(doc.data(), doc.id));
      }
    });

    return todos;
  }

  @override
  Future<void> register({required TodoModel todo}) async {
    prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("USER_ID");

    todo = todo.copyWith(user_id: userId);
    await db.collection("todos").add(todo.toMap());
  }

  @override
  Future<void> delete({required String id}) async {
    try {
      await db.collection('todos').doc(id).delete();
    } on Exception catch (e, s) {
      log("Erro ao deletar Todo", error: e, stackTrace: s);
      print(e.toString());
    }
  }
  
  @override
  Future<void> updateStatus({required TodoModel todo}) async{
    await db.collection("todos").doc(todo.id).update({
      'finished' : !todo.finished
    });
  }
  
  @override
  Future<void> updateDescription({required TodoModel todo}) async {
    await db.collection("todos").doc(todo.id).update({
      'description' : todo.description
    });
  }
  

}

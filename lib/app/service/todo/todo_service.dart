import 'package:flutter_firebase/app/model/todo_model.dart';

abstract class TodoService {
  Future<List<TodoModel>> getAll();
  Future<void> register({required TodoModel todo});

  Future<void> delete({required String id});
    Future<void> updateStatus({required TodoModel todo});
      Future<void> updateDescription({required TodoModel todo});
}

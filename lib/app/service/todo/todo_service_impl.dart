import 'package:flutter_firebase/app/model/todo_model.dart';
import 'package:flutter_firebase/app/repository/todo/todo_repository.dart';

import './todo_service.dart';

class TodoServiceImpl extends TodoService {
  
  final TodoRepository _todoRepository;

  TodoServiceImpl({required TodoRepository todoRepository}) : _todoRepository = todoRepository;

  @override
  Future<List<TodoModel>> getAll() async {
    return await _todoRepository.getAll();
  }
  
  @override
  Future<void> register({required TodoModel todo}) async{
    return await _todoRepository.register(todo: todo);
  }
  
  @override
  Future<void> delete({required String id}) async{
    return await _todoRepository.delete(id: id);
  }
  
  @override
  Future<void> updateStatus({required TodoModel todo}) async{
    return await _todoRepository.updateStatus(todo: todo);
  }
  
  @override
  Future<void> updateDescription({required TodoModel todo}) async{
    await _todoRepository.updateDescription(todo: todo);
  }

}
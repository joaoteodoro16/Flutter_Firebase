
import 'package:flutter_firebase/app/core/state/global_state.dart';
import 'package:flutter_firebase/app/model/message_model.dart';
import 'package:flutter_firebase/app/model/todo_model.dart';
import 'package:flutter_firebase/app/service/todo/todo_service.dart';

class HomeController extends GlobalState{
  final TodoService _todoService;
  List<TodoModel> todos = [];
  HomeController({required TodoService todoService}) : _todoService = todoService;

  Future<void> getAllTodos()async{
    showLoading();
    todos = await _todoService.getAll();
    hideLoading();
    notifyListeners();
  }

  Future<void> registerTodo({required TodoModel todo})async{
    showLoading();
    await _todoService.register(todo: todo);
    hideLoading();
  }

  Future<void> deleteTodo({required String id})async {
    showLoading();
    await _todoService.delete(id: id);
    hideLoading();
    showMessage("Tarefa deletada com sucesso!", MessageType.success);
  }

  Future<void> updateStatusTodo({required TodoModel todo})async{
    showLoading();
    await _todoService.updateStatus(todo: todo);
    hideLoading();
  }

  Future<void> updateDescription({required TodoModel todo})async {
    showLoading();
    await _todoService.updateDescription(todo: todo);
    hideLoading();
    showMessage("Tarefa alterada com sucesso!", MessageType.success);
  }



}
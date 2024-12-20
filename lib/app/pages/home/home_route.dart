import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/model/user_model.dart';
import 'package:flutter_firebase/app/pages/home/home_controller.dart';
import 'package:flutter_firebase/app/pages/home/home_page.dart';
import 'package:flutter_firebase/app/repository/todo/todo_repository.dart';
import 'package:flutter_firebase/app/repository/todo/todo_repository_impl.dart';
import 'package:flutter_firebase/app/service/todo/todo_service.dart';
import 'package:flutter_firebase/app/service/todo/todo_service_impl.dart';
import 'package:provider/provider.dart';

class HomeRoute {
  HomeRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<TodoRepository>(create: (context) => TodoRepositoryImpl(),),
          Provider<TodoService>(create: (context) => TodoServiceImpl(todoRepository: context.read()),),
          ChangeNotifierProvider(create: (context) => HomeController(todoService: context.read()),)
        ],
        builder: (context, child){
          final args = ModalRoute.of(context)?.settings.arguments as UserModel;
          return  HomePage(userLogged: args,);
        },
      );
}

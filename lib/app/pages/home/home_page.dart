import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/core/state/base_state.dart';
import 'package:flutter_firebase/app/model/user_model.dart';
import 'package:flutter_firebase/app/pages/home/home_controller.dart';
import 'package:flutter_firebase/app/pages/home/widgets/dialog_todo_widget.dart';
import 'package:flutter_firebase/app/pages/home/widgets/home_drawer.dart';
import 'package:flutter_firebase/app/pages/home/widgets/todo_card_widget.dart';

import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  final UserModel userLogged;
  const HomePage({
    super.key,
    required this.userLogged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() async {
    await controller.getAllTodos();
    super.onReady();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  HomeDrawer(userLogged: widget.userLogged),
      appBar: AppBar(
        title: const Text("Minhas Tarefas"),
        actions: [
          IconButton(
            onPressed: () async {
              await DialogTodoWidget.showTodoDialog(context);
              await controller.getAllTodos();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getAllTodos();
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView.builder(
                itemCount: controller.todos.length,
                itemBuilder: (context, index) {
                  final todo = controller.todos[index];
                  return TodoCardWidget(todo: todo);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

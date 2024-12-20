import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/model/todo_model.dart';
import 'package:flutter_firebase/app/pages/home/home_controller.dart';
import 'package:flutter_firebase/app/pages/home/widgets/dialog_todo_widget.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:provider/provider.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoModel todo;
  const TodoCardWidget({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeController>();

    final finished = todo.finished;
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: InkWell(
          onTap: () async {
            await DialogTodoWidget.showTodoDialog(context, todo);
            await controller.getAllTodos();
          },
          child: Card(
            child: ListTile(
              title: Text(
                todo.description,
                style: TextStyle(
                  color: finished ? Colors.grey[600] : Colors.black,
                  decoration: finished ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () async {
                        PanaraInfoDialog.show(
                          context,
                          message: "Deseja realmente excluir essa tarefa?",
                          buttonText: "Confirmar",
                          onTapDismiss: () async {
                            final navigator = Navigator.of(context);
                            await controller.deleteTodo(id: todo.id!);
                            await controller.getAllTodos();
                            navigator.pop();
                          },
                          panaraDialogType: PanaraDialogType.warning,
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      )),
                  IconButton(
                    onPressed: () async {
                      await controller.updateStatusTodo(todo: todo);
                      await controller.getAllTodos();
                    },
                    icon: Icon(
                      finished
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/pages/home/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/widgets/app_text_form_field_widget.dart';
import '../../../model/todo_model.dart';

class DialogTodoWidget {
  
  DialogTodoWidget._();

  static Future<void> showTodoDialog(BuildContext context,[TodoModel? todoUpdate]) async {    
    final formKey = GlobalKey<FormState>();
    final descriptionEC = TextEditingController();
    final controller = context.read<HomeController>();
    String title = 'Nova Tarefa';
    bool isUpdate = false;

    if(todoUpdate != null){
      title = 'Editar Tarefa';
      isUpdate = true;
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: isUpdate ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(todoUpdate!.description),
            ],
          ) : Text(title),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppTextFormFieldWidget(
                    label: 'Descrição',
                    controller: descriptionEC,
                    validator: Validatorless.required("Campo obrigatório!"),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
            ),
            TextButton(
              child: const Text('Salvar'),
              onPressed: () async {
                final navigator = Navigator.of(context);
                final validate = formKey.currentState?.validate() ?? false;
                if (validate) {
                  final todo = TodoModel(
                    id: isUpdate ? todoUpdate!.id : null,
                    description: descriptionEC.text,
                    finished: isUpdate ? todoUpdate!.finished : false,
                    user_id: '',
                  );

                  if(isUpdate){
                    await controller.updateDescription(todo: todo);
                  }else{
                    await controller.registerTodo(todo: todo);
                  }
                  
                  navigator.pop();
                }
              },
            ),
          ],
        );
      },
    );
  }


}
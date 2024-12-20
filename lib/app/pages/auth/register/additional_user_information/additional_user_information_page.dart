import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/core/state/base_state.dart';
import 'package:flutter_firebase/app/core/ui/widgets/app_text_form_field_widget.dart';
import 'package:flutter_firebase/app/model/user_model.dart';
import 'package:flutter_firebase/app/pages/auth/register/additional_user_information/additional_user_information_controller.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class AdditionalUserInformationPage extends StatefulWidget {
  final UserModel? userLogged;
  const AdditionalUserInformationPage({super.key, this.userLogged});

  @override
  State<AdditionalUserInformationPage> createState() =>
      _AdditionalUserInformationPageState();
}

class _AdditionalUserInformationPageState extends BaseState<
    AdditionalUserInformationPage, AdditionalUserInformationController> {
  final _nameEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameEC.dispose();
    super.dispose();
  }

  @override
  void onReady() {
    if (widget.userLogged != null) {
      controller.setUser(user: widget.userLogged!);
    }
    super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações Adicionais'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Selector<AdditionalUserInformationController, UserModel?>(
                selector: (p0, p1) => controller.userLogged,
                builder: (context, user, child) {
                  return CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[200],
                    child: user == null || user.pathImage == ''
                        ? const Icon(Icons.person, size: 60)
                        : ClipOval(
                            child: Image.file(
                              File(user.pathImage),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                  );
                },
              ),
              TextButton(
                onPressed: () async {
                  await controller.setImage();
                },
                child: const Text("Alterar foto"),
              ),
              const SizedBox(
                height: 10,
              ),
              AppTextFormFieldWidget(
                label: 'Nome Completo',
                controller: _nameEC,
                validator: Validatorless.required("Campo obrigatório!"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final validator = _formKey.currentState?.validate() ?? false;
                  if (validator) {
                    await controller.updateAdditionalInformation(
                      UserModel.updateUserProfile(name: _nameEC.text)
                    );
                    navigator.pushNamedAndRemoveUntil('/home', (route) => false, arguments: controller.userLogged);
                  }
                },
                child: const Text("Continuar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

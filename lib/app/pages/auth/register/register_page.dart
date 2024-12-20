import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/pages/auth/register/register_controller.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/state/base_state.dart';
import '../../../core/ui/widgets/app_text_form_field_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: Consumer(
        builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    
                    AppTextFormFieldWidget(
                      label: "Email",
                      controller: _emailEC,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo obrigatório!"),
                        Validatorless.email("Email inválido!")
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextFormFieldWidget(
                      label: "Senha",
                      controller: _passwordEC,
                      obscureText: true,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo obrigatório!"),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextFormFieldWidget(
                      label: "Confirmar Senha",
                      obscureText: true,
                      validator: Validatorless.multiple([
                        Validatorless.required("Campo obrigatório!"),
                        Validatorless.compare(
                            _passwordEC, "As senhas devem ser iguais!")
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        final validate =
                            _formKey.currentState?.validate() ?? false;
                        if (validate) {
                          await controller.register(
                            email: _emailEC.text,
                            password: _passwordEC.text,
                          );
                          if(controller.userCredential != null){
                            navigator.pop();
                          }
                        }
                      },
                      child: const Text("Confirmar"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/core/state/base_state.dart';
import 'package:flutter_firebase/app/core/ui/widgets/app_text_form_field_widget.dart';
import 'package:flutter_firebase/app/model/user_model.dart';
import 'package:flutter_firebase/app/pages/auth/login/login_controller.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginController> {
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
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
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
                ElevatedButton(
                  onPressed: () async {
                    final navigator = Navigator.of(context);
                    final validate = _formKey.currentState?.validate() ?? false;
                    if (validate) {
                      await controller.login(
                          email: _emailEC.text, password: _passwordEC.text);
                      if (controller.userLogged != null) {
                        final user = controller.userLogged!.user;

                        final userModel = UserModel(
                          id: user!.uid,
                          name: user.displayName ?? '',
                          pathImage: user.photoURL ?? '',
                          email: user.email ?? '',
                        );

                        if (user.displayName == null) {
                          navigator.pushNamedAndRemoveUntil(
                            '/auth/register/additional_user_information',
                            (route) => false,
                            arguments: userModel,
                          );
                        } else {
                          navigator.pushNamedAndRemoveUntil(
                            '/home',
                            (route) => false,
                            arguments: userModel,
                          );
                        }
                      }
                    }
                  },
                  child: const Text("Acessar"),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/auth/register');
                  },
                  child: const Text('Registrar-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

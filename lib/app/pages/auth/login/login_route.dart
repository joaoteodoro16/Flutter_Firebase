import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/pages/auth/login/login_controller.dart';
import 'package:flutter_firebase/app/pages/auth/login/login_page.dart';
import 'package:flutter_firebase/app/repository/user/user_repository.dart';
import 'package:flutter_firebase/app/repository/user/user_repository_impl.dart';
import 'package:flutter_firebase/app/service/user/user_service.dart';
import 'package:flutter_firebase/app/service/user/user_service_impl.dart';
import 'package:provider/provider.dart';


class LoginRoute {
  LoginRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<UserRepository>(create: (context) => UserRepositoryImpl(),),
          Provider<UserService>(create: (context) => UserServiceImpl(userrepository: context.read()),),
          ChangeNotifierProvider(create: (context) => LoginController(userService: context.read()),)
        ],
        builder: (context, child) => const LoginPage(),
      );
}

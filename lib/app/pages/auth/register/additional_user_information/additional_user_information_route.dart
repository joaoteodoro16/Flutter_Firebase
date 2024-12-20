import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/model/user_model.dart';
import 'package:flutter_firebase/app/pages/auth/register/additional_user_information/additional_user_information_controller.dart';
import 'package:flutter_firebase/app/pages/auth/register/additional_user_information/additional_user_information_page.dart';
import 'package:flutter_firebase/app/repository/user/user_repository.dart';
import 'package:flutter_firebase/app/repository/user/user_repository_impl.dart';
import 'package:flutter_firebase/app/service/user/user_service.dart';
import 'package:flutter_firebase/app/service/user/user_service_impl.dart';
import 'package:provider/provider.dart';

class AdditionalUserInformationRoute {
  AdditionalUserInformationRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<UserRepository>(create: (context) => UserRepositoryImpl(),),
          Provider<UserService>(create: (context) => UserServiceImpl(userrepository: context.read()),),
          ChangeNotifierProvider(create: (context) => AdditionalUserInformationController(userService: context.read()),)
        ],
        builder: (context, child){
          final args = ModalRoute.of(context)?.settings.arguments  as UserModel?;
          return AdditionalUserInformationPage(userLogged: args);
        },
      );
}

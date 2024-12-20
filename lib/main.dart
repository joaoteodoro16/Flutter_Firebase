import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/core/provider/application_binding.dart';
import 'package:flutter_firebase/app/pages/auth/login/login_page.dart';
import 'package:flutter_firebase/app/pages/auth/login/login_route.dart';
import 'package:flutter_firebase/app/pages/auth/register/additional_user_information/additional_user_information_route.dart';
import 'package:flutter_firebase/app/pages/auth/register/register_route.dart';
import 'package:flutter_firebase/app/pages/home/home_route.dart';

import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        initialRoute: '/auth/login',
        routes: {
          '/auth/login' : (context) => LoginRoute.page,
          '/auth/register' : (context) => RegisterRoute.page,
          '/auth/register/additional_user_information' : (context) => AdditionalUserInformationRoute.page,
          '/home' : (context) => HomeRoute.page,
        },
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/app/core/exceptions/email_not_verified_exception.dart';
import 'package:flutter_firebase/app/core/state/global_state.dart';
import 'package:flutter_firebase/app/model/message_model.dart';
import 'package:flutter_firebase/app/service/user/user_service.dart';

class LoginController extends GlobalState {
  final UserService _userService;
  UserCredential? userLogged;

  LoginController({required UserService userService})
      : _userService = userService;

  Future<void> login({required String email, required String password}) async {
    try {
      showLoading();
      userLogged =  await _userService.login(email: email, password: password);
      hideLoading();
    } on EmailNotVerifiedException catch (e) {
      hideLoading();
      showMessage(e.message, MessageType.info);
    } on FirebaseAuthException catch (e) {
      hideLoading();
      showMessage(e.message ?? 'Erro inesperado!', MessageType.error);
    } catch (e) {
      hideLoading();
      showMessage(e.toString(), MessageType.error);
    }
  }
}

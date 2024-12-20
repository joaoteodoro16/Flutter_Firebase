import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/app/core/state/global_state.dart';
import 'package:flutter_firebase/app/model/message_model.dart';
import 'package:flutter_firebase/app/service/user/user_service.dart';

class RegisterController extends GlobalState {
  final UserService _userService;
  UserCredential? userCredential;

  RegisterController({required UserService userService}) : _userService = userService;

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      showLoading();
      userCredential = await _userService.register(email: email, password: password);
      hideLoading();
      showMessage("Conta cadastrada com sucesso!", MessageType.success);
    } on FirebaseAuthException catch (e) {
      hideLoading();
      showMessage(e.message ?? 'Erro inesperado!', MessageType.error);
    } catch (e) {
      hideLoading();
      showMessage(e.toString(), MessageType.error);
    }
  }
}

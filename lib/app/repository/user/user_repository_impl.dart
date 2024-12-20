import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_firebase/app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/exceptions/email_not_verified_exception.dart';
import 'user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential?> register(
      {required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final acs = ActionCodeSettings(
          url: "https://joaoteodoro.page.link",
          handleCodeInApp: true,
          androidInstallApp: true,
          androidMinimumVersion: '12',
          androidPackageName: "br.com.joaoteodoro.flutter_firebase");
      await _firebaseAuth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: acs);

      return userCredential;
    } on FirebaseAuthException catch (e, s) {
      String message = "";

      switch (e.code) {
        case "email-already-in-use":
          message = "Email já cadastrado no sistema!";
          log(message, error: e, stackTrace: s);
          break;
        case "too-many-requests":
          message =
              "Número de envio de confirmações de email excedidas! Tente novamente mais tarde.";
          log(message, error: e, stackTrace: s);
          break;
        default:
          message = "Erro inesperado ao tentar registrar o usuário.";
          log(message, error: e, stackTrace: s);
      }
      throw FirebaseAuthException(code: e.code, message: message);
    } catch (e, s) {
      const message = "Erro ao tentar registrar o usuário";
      log(message, error: e, stackTrace: s);
      throw Exception(message);
    }
  }

  @override
  Future<UserCredential?> login(
      {required String email, required String password}) async {
    try {
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      // TODO: Verificar o Dynamic link para confirmar o email
      // if (user.user != null) {
      //   if (user.user!.emailVerified == false) {
      //     throw EmailNotVerifiedException(
      //         message: "Por favor, realize a confirmação do email");
      //   }
      // }
      
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("USER_ID", user.user?.uid ?? '');

      return user;
    } on FirebaseAuthException catch (e, s) {
      String message = "";
      switch (e.code) {
        case "invalid-credential":
          message = "Usuário ou senha inválidos!";
          log(message, error: e, stackTrace: s);
          break;
        case "user-disabled":
          message = "Conta desativada, entre em contato com o suporte!";
          log(message, error: e, stackTrace: s);
          break;
        default:
          message = "Erro inesperado ao tentar registrar o usuário.";
          log(message, error: e, stackTrace: s);
      }
      throw FirebaseAuthException(code: e.code, message: message);
    } on EmailNotVerifiedException catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      rethrow;
    } catch (e, s) {
      const message = "Erro ao tentar realizar o login";
      log(message, error: e, stackTrace: s);
      throw Exception(message);
    }
  }

  @override
  Future<User?> updateAdditionalInformation({required UserModel user}) async {
    User? userLogged = _firebaseAuth.currentUser;

    if (userLogged != null) {
      await userLogged.updateDisplayName(user.name);

      //TODO: Configurar para conseguir realizar o Upload das imagens
      // if (user.pathImage != '') {
      //   final storageRef = FirebaseStorage.instance
      //       .ref()
      //       .child('user_avatars')
      //       .child('${user.id}.jpg');

      //   await storageRef.putFile(File(user.pathImage));

      //   String avatarUrl = await storageRef.getDownloadURL();

      //   await userLogged.updatePhotoURL(avatarUrl);
      // }

      // Atualize o perfil no Firebase Authentication
      await userLogged.reload();
      return _firebaseAuth.currentUser;
    }
    return null;
  }
  
  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}

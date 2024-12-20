import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/app/core/exceptions/email_not_verified_exception.dart';
import 'package:flutter_firebase/app/model/user_model.dart';
import 'package:flutter_firebase/app/repository/user/user_repository.dart';
import 'package:image_picker/image_picker.dart';
import './user_service.dart';

class UserServiceImpl extends UserService {
  final UserRepository _userRepository;

  UserServiceImpl({required UserRepository userrepository})
      : _userRepository = userrepository;

  @override
  Future<UserCredential?> register(
      {required String email, required String password}) async {
    try {
      return await _userRepository.register(email: email, password: password);
    } on EmailNotVerifiedException catch (e) {
      rethrow;
    } on FirebaseAuthException catch (_) {
      rethrow;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserCredential?> login(
      {required String email, required String password}) async {
    return await _userRepository.login(email: email, password: password);
  }
  

  @override
  Future<User?> updateAdditionalInformation({required UserModel user}) {
    return _userRepository.updateAdditionalInformation(user: user);
  }
  
  @override
  Future<File?> setImage({required String pathOldImageSelected}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null){
      return File(pickedFile.path);
    }else{
      if(pathOldImageSelected != ''){
        return File(pathOldImageSelected);
      }else{
        return null;
      }
    }
  }
  

  

}

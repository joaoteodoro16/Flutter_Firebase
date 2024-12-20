import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/app/model/user_model.dart';

abstract class UserService {
  Future<UserCredential?> register({required String email, required String password});
  Future<UserCredential?> login({required String email,required String password});
  Future<User?> updateAdditionalInformation({required UserModel user});
  Future<File?> setImage({required String pathOldImageSelected});
}
import 'package:flutter_firebase/app/core/state/global_state.dart';
import 'package:flutter_firebase/app/model/user_model.dart';
import 'package:flutter_firebase/app/service/user/user_service.dart';

class AdditionalUserInformationController extends GlobalState {
  final UserService _userService;

  AdditionalUserInformationController(
      {required UserService userService, UserModel? user})
      : _userService = userService;
  UserModel userLogged = UserModel.empty();

  void setUser({required UserModel user}) {
    userLogged = user;
    notifyListeners();
  }

  Future<void> setImage() async {
    final filePathImage =
        await _userService.setImage(pathOldImageSelected: userLogged.pathImage);
    userLogged = userLogged.copyWith(pathImage: filePathImage?.path ?? '');
    notifyListeners();
  }

  Future<void> updateAdditionalInformation(UserModel user) async {
    userLogged = userLogged.copyWith(name: user.name);
    final newUser =
        await _userService.updateAdditionalInformation(user: userLogged);
    userLogged = userLogged.copyWith(
      id: newUser!.uid,
      email: newUser.email,
      name: newUser.displayName,
      pathImage: newUser.phoneNumber
    );
    notifyListeners();
  }
}

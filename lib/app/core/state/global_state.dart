
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/model/message_model.dart';

class GlobalState extends ChangeNotifier{

  bool _isLoading = false;
  bool _isLoadingVisible = false;
  MessageModel? _message;

  bool get isLoading => _isLoading;
  bool get isLoadingVisible => _isLoadingVisible;
  MessageModel? get message => _message;

  void showLoading(){
    _isLoadingVisible = true;
    _isLoading = true;
    notifyListeners();
  }

  void hideLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void showMessage(String message, MessageType type) async {
    _message = MessageModel(message: message, type: type);
    notifyListeners();

    _message = null;
    _isLoadingVisible = false;
    notifyListeners();
    
  }
}
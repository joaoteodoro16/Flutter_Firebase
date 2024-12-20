import 'package:flutter/material.dart';
import 'package:flutter_firebase/app/core/state/global_state.dart';
import 'package:flutter_firebase/app/core/ui/helpers/loader.dart';
import 'package:flutter_firebase/app/core/ui/helpers/messages.dart';
import 'package:flutter_firebase/app/model/message_model.dart';
import 'package:provider/provider.dart';

abstract class BaseState<T extends StatefulWidget, C extends GlobalState> extends State<T> with Messages, Loader{

  late final C controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<C>();

    controller.addListener(_onStateChange);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
    
  }

  void onReady(){}

  void _onStateChange() {
    if (controller.isLoading && controller.message == null) {
      showLoader();
    }

    if (!controller.isLoading &&
        controller.message == null &&
        controller.isLoadingVisible) {
      hideLoader();
    }

    if (controller.message != null && !controller.isLoading) {
      if(controller.message!.type == MessageType.info){
        showInfo(controller.message!.message);
      }else if(controller.message!.type == MessageType.error){
        showError(controller.message!.message);
      }else{
        showSuccess(controller.message!.message);
      }
    }
  }
}


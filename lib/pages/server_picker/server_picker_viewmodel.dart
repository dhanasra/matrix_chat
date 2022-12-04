import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/config/app_config.dart';
import 'package:instrive_chat/pages/base/base_view_model.dart';

import '../../bloc/authentication/auth_bloc.dart';

class ServerPickerViewModel extends BaseViewModel{

  ServerPickerViewModel._internal();
  static final ServerPickerViewModel _serverPickerViewModel = ServerPickerViewModel._internal();
  factory ServerPickerViewModel(){
    return _serverPickerViewModel;
  }

  late TextEditingController homeServerController;
  late GlobalKey<FormState> formKey;
    
  @override
  void start() {
    homeServerController = TextEditingController(text: AppConfig.defaultBrowser);
    formKey = GlobalKey<FormState>();
  }

  void checkHomeServer(BuildContext context){
    if(!formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      CheckHomeServer(homeServer: homeServerController.text)
    );
  }
  
  @override
  void dispose() {
    homeServerController.dispose();
  }

}
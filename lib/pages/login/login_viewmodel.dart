import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/bloc/authentication/auth_bloc.dart';
import 'package:instrive_chat/pages/base/base_view_model.dart';

class LoginViewModel extends BaseViewModel{

  LoginViewModel._internal();
  static final LoginViewModel _loginViewModel = LoginViewModel._internal();
  factory LoginViewModel(){
    return _loginViewModel;
  } 

  String? homeBrowserName;

  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late ValueNotifier<bool> isPasswordVisible;

  late GlobalKey<FormState> formKey;


  @override
  void start() {
    userNameController = TextEditingController(text: "dhanasra");
    passwordController = TextEditingController(text: "dhanatest");

    isPasswordVisible = ValueNotifier<bool>(true);

    formKey = GlobalKey<FormState>();
  }

  void loginUser(BuildContext context){

    if(!formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      LoginUser(
        password: passwordController.text, 
        username: userNameController.text)
    );
    
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
  }

}
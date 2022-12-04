import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/pages/base/base_view_model.dart';

import '../../bloc/authentication/auth_bloc.dart';

class SignupViewModel extends BaseViewModel {

  late TextEditingController userNameController;
  late TextEditingController passwordController;
  late TextEditingController passwordRepeatController;

  late GlobalKey<FormState> formKey;

  @override
  void start() {

    userNameController = TextEditingController();
    passwordController = TextEditingController();
    passwordRepeatController = TextEditingController();

    formKey = GlobalKey<FormState>();
  }

  void checkUserNameAvailability(BuildContext context){
    if(!formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      CheckUserNameIsAvailable(username: userNameController.text)
    );
  }

  void registerUser(BuildContext context){
    if(!formKey.currentState!.validate()) return;

    var username = ModalRoute.of(context)!.settings.arguments as String;

    context.read<AuthBloc>().add(
      SignupUser(
        username: username,
        password: passwordController.text,
        cPassword: passwordRepeatController.text
      )
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    passwordRepeatController.dispose();
  }

}
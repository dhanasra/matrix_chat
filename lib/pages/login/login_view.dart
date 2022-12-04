import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/app/app_routes.dart';
import 'package:instrive_chat/bloc/authentication/auth_bloc.dart';
import 'package:instrive_chat/pages/login/login_viewmodel.dart';
import 'package:instrive_chat/widgets/buttonWL.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late LoginViewModel _viewModel;

  @override
  void initState() {
    _viewModel = LoginViewModel();
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _viewModel.homeBrowserName = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (_, state){
            if(state is LoginSuccess){
              Navigator.of(context).pushNamed(Routes.roomsPage);
            }else if(state is Failure){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message))
              );
            }
          },
          builder: (_, state){
            return Form(
              key: _viewModel.formKey,
              child: LoginFields(
                isLoading: state is Loading,
                viewModel: _viewModel,
              )
            );                
          }),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class LoginFields extends StatelessWidget {
  final LoginViewModel viewModel;
  final bool isLoading;
  const LoginFields({
    super.key,
    required this.isLoading,
    required this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        Padding(
          padding: const EdgeInsets.all(36),
          child: Text("Login to ${viewModel.homeBrowserName}", 
          style: Theme.of(context).textTheme.headline5),  
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: TextFormField(
            controller: viewModel.userNameController,
            readOnly: isLoading,
            decoration: const InputDecoration(
              labelText: "User name",
              border: OutlineInputBorder()
            ),
            validator: (value){
              if(value==null || value.isEmpty){
                return "User name is required";
              }else{
                return null;
              }
            },
          ),  
        ),

        Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            child: ValueListenableBuilder<bool>(
                valueListenable: viewModel.isPasswordVisible,
                builder: (context, value, child){
                  return TextFormField(
                    controller: viewModel.passwordController,
                    readOnly: isLoading,
                    obscureText: value,
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () => viewModel.isPasswordVisible.value = !viewModel.isPasswordVisible.value, 
                        icon: Icon( value ? Icons.lock : Icons.lock_open ),
                        splashRadius: 18,
                      )
                    ),
                    validator: (value){
                    if(value==null || value.isEmpty){
                      return "Password is required";
                    }else{
                      return null;
                    }
                  },
                );
              }
            ),  
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
          child: ButtonWL(
            isLoading: isLoading, 
            onPressed: ()=>viewModel.loginUser(context), 
            text: "LOGIN")
        ),

        const Text("OR"),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
          child: ButtonWL( 
            onPressed: ()=>Navigator.of(context).pushNamed(Routes.signup), 
            lighter: true,
            text: "SIGN UP")
        ),
        
      ],
    );
  }
}
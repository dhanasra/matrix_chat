import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/bloc/authentication/auth_bloc.dart';
import 'package:instrive_chat/pages/signup/signup_viewmodel.dart';

class SignupPasswordView extends StatefulWidget {
  const SignupPasswordView({super.key});

  @override
  State<SignupPasswordView> createState() => _SignupPasswordViewState();
}

class _SignupPasswordViewState extends State<SignupPasswordView> {

  late SignupViewModel _viewModel;

  @override
  void initState() {
    _viewModel = SignupViewModel();

    _viewModel.start();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state){
          if(state is PasswordMismatch){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password and Confirm password must be match."), behavior: SnackBarBehavior.floating,)
            );
          }else if(state is Failure){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), behavior: SnackBarBehavior.floating,)
            );
          }
        },
        builder: (_, state){
          return Form(
            key: _viewModel.formKey,
            child: SignupPasswordField(
              viewModel: _viewModel,
              isLoading: state is Loading,
          ));
        }
      ),
    );
  }
}

class SignupPasswordField extends StatelessWidget {
  final SignupViewModel viewModel;
  final bool isLoading;
  const SignupPasswordField({
    super.key,
    required this.viewModel,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: TextFormField(
              controller: viewModel.passwordController,
              readOnly: isLoading,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder()
              ),
              validator: (value){
              if(value==null || value.isEmpty){
                return "Password is required";
              }else{
                return null;
              }
            },
            ),  
          ),

        Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: TextFormField(
              controller: viewModel.passwordRepeatController,
              readOnly: isLoading,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder()
              ),
              validator: (value){
              if(value==null || value.isEmpty){
                return "Confirm Password is required";
              }else{
                return null;
              }
            },
            ),  
          ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
          child: MaterialButton(
            minWidth: double.infinity,
            height: 60,
            color: Colors.amber,
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)
            ),
            child: isLoading
              ? const LinearProgressIndicator()
              : const Text("SIGN UP", style: TextStyle(fontWeight: FontWeight.w800)),
            onPressed: ()=>viewModel.registerUser(context),
          )
        ),

      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/app/app_routes.dart';
import 'package:instrive_chat/bloc/authentication/auth_bloc.dart';
import 'package:instrive_chat/pages/signup/signup_viewmodel.dart';

class SignupNameView extends StatefulWidget {
  const SignupNameView({super.key});

  @override
  State<SignupNameView> createState() => _SignupNameViewState();
}

class _SignupNameViewState extends State<SignupNameView> {

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
          if(state is UserNameAvailable){
            Navigator.of(context).pushNamed(
              Routes.signupPassword, arguments: _viewModel.userNameController.text);
          }else if(state is Failure){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), behavior: SnackBarBehavior.floating,)
            );
          }
        },
        builder: (_, state){
          return SingleChildScrollView(
            child: Form(
              key: _viewModel.formKey,
              child: SignupNameField(
                viewModel: _viewModel,
                isLoading: state is Loading,
            )),
          );
        }
      ),
    );
  }
}

class SignupNameField extends StatelessWidget {
  final SignupViewModel viewModel;
  final bool isLoading;
  const SignupNameField({
    super.key,
    required this.isLoading,
    required this.viewModel  
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: TextFormField(
            controller: viewModel.userNameController,
            readOnly: isLoading,
            decoration: const InputDecoration(
              labelText: "User Name",
              border: OutlineInputBorder(),
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
            onPressed: ()=>viewModel.checkUserNameAvailability(context),
          )
        ),

      ],
    );
  }
}
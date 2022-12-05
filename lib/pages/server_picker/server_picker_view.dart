import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/app/app_routes.dart';
import 'package:instrive_chat/bloc/authentication/auth_bloc.dart';
import 'package:instrive_chat/pages/server_picker/server_picker_viewmodel.dart';

class ServerPickerView extends StatefulWidget {
  const ServerPickerView({super.key});

  @override
  State<ServerPickerView> createState() => _ServerPickerViewState();
}

class _ServerPickerViewState extends State<ServerPickerView> {

  late ServerPickerViewModel _viewModel;

  @override
  void initState() {
    _viewModel = ServerPickerViewModel();
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (_, state){
          if(state is HomeServerType){
          
            Navigator.of(context).pushNamed( 
              state.isRegistrationSupported ? Routes.signup : Routes.loginPage , 
              arguments: _viewModel.homeServerController.text);
          
          }else if(state is Failure){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (_, state){
          return Form(
            key: _viewModel.formKey,
            child: ServerPickerFields(
              isLoading: state is Loading, 
              viewModel: _viewModel
          ));
        }),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class ServerPickerFields extends StatelessWidget {
  final ServerPickerViewModel viewModel;
  final bool isLoading;

  const ServerPickerFields({
    super.key,
    required this.isLoading,
    required this.viewModel  
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [

        Image.asset("assets/images/logo.png", height: 125),

        Text("Welcome To Instrive Chat", style: Theme.of(context).textTheme.headline6,),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: TextFormField(
            controller: viewModel.homeServerController,
            readOnly: isLoading,
            decoration: const InputDecoration(
              labelText: "Home Browser"
            ),
            validator: (value){
              if(value==null || value.isEmpty){
                return "Home Browser is required";
              }else{
                return null;
              }
            },
          ),  
        ),

        const Spacer(),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
          child: ElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              minimumSize: MaterialStateProperty.all(
                Size( isLoading ? 0 : double.infinity , 58))
            ),
            child: isLoading
              ? const SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white
                  ),
              )
              : const Text("CONNECT", style: TextStyle(fontWeight: FontWeight.w800)),
            onPressed: ()=>viewModel.checkHomeServer(context),
          )
        ),

        ],
      );
  }
}
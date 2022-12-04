import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/bloc/authentication/auth_bloc.dart';
import 'package:instrive_chat/bloc/chat/chat_bloc.dart';
import 'package:instrive_chat/bloc/room/room_bloc.dart';
import 'package:instrive_chat/pages/chat/chat_view.dart';
import 'package:instrive_chat/pages/login/login_view.dart';
import 'package:instrive_chat/pages/rooms/rooms_view.dart';
import 'package:instrive_chat/pages/server_picker/server_picker_view.dart';
import 'package:instrive_chat/pages/signup/name.dart';
import 'package:instrive_chat/pages/signup/password.dart';
import 'package:instrive_chat/pages/splash/splash_view.dart';

class Routes{

  static const splashPage = "splash_page";

  static const serverPage = "server_page";
  static const loginPage = "login_page";
  static const signup = "signup_page";
  static const signupPassword = "signup_password_page";
  
  static const roomsPage = "rooms_page";
  
  static const chatPage = "chat_page";

  static Route getPages(RouteSettings settings){

    switch(settings.name){

      case splashPage: return MaterialPageRoute(
        settings: settings,
        builder: (_)=>const SpalshView()
      );

      case serverPage: return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider(
          create: (_)=>AuthBloc(), 
          child: const ServerPickerView()
        )
      );

      case signupPassword: return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider(
          create: (_)=>AuthBloc(), 
          child: const SignupPasswordView()
        )
      );

      case signup: return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider(
          create: (_)=>AuthBloc(), 
          child: const SignupNameView()
        )
      );

      case loginPage: return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider(
          create: (_)=>AuthBloc(), 
          child: const LoginView()
        )
      );

      case roomsPage: return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider(
          create: (_)=>RoomBloc(),
          child: const RoomsView(),
        )
      );

      case chatPage: return MaterialPageRoute(
        settings: settings,
        builder: (_) => BlocProvider(
          create: (_)=>ChatBloc(),
          child: ChatView(roomId: settings.arguments as String,),
        )
      );
    
      default : return MaterialPageRoute(builder: (_)=>const NoRoutesFound());
    }

  }

}


class NoRoutesFound extends StatelessWidget {
  const NoRoutesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("No Routes Found"),
      ),
    );
  }
}
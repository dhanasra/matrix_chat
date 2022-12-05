

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:instrive_chat/app/app_config.dart';
import 'package:instrive_chat/config/matrix.dart';
import 'package:matrix/matrix.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthBlocInitial()) {
    on<LoginUser>(onLoginUser);
    on<CheckUserNameIsAvailable>(onCheckUserNameIsAvailable);
    on<SignupUser>(onSignupUser);
    on<CheckHomeServer>(onCheckHomeServer);
  }
}

void onCheckHomeServer(CheckHomeServer event, Emitter emit) async{
  emit(Loading());

  try{

    var homeserverText = event.homeServer.trim().toLowerCase().replaceAll(' ', '-');
    var homeserver = Uri.parse(homeserverText);
    if (homeserver.scheme.isEmpty) {
      homeserver = Uri.https(homeserverText, '');
    }

    var homeserverSummary = await AppMatrix.client.checkHomeserver(homeserver);
    var ssoSupported = homeserverSummary.loginFlows.any((flow) => flow.type=='m.login.sso');

    var isRegistrationSupported = true;
    
    try {
      await AppMatrix.client.register();
    } on MatrixException catch (e) {
      isRegistrationSupported = e.requireAdditionalAuthentication;
    }

    emit(
      HomeServerType( 
        isRegistrationSupported: !ssoSupported && isRegistrationSupported == false)
    );

  }catch(e){
    emit(Failure(message: e.toString()));
  }

}

void onSignupUser(SignupUser event, Emitter emit) async{
  emit(Loading());

  if(event.password!=event.cPassword){
    emit(PasswordMismatch());
    return;
  }

  try{
    await AppMatrix.client.uiaRequestBackground((auth) => AppMatrix.client.register(
        username: event.username,
        password: event.password,
        initialDeviceDisplayName: AppConfig.clientName,
        auth: auth
      ));
    emit(SignupSuccess());
  }catch(e){
    emit(Failure(message: e.toString()));
  }
}

void onCheckUserNameIsAvailable(CheckUserNameIsAvailable event, Emitter emit) async{
  emit(Loading());
  
  try{
    await AppMatrix.client.register(username: event.username);
    emit(UserNameAvailable());
  }on MatrixException catch(e){
    if(e.requireAdditionalAuthentication){
      emit(UserNameAvailable());
    }else{
      emit(Failure(message: e.errorMessage));
    }
  }

}

void onLoginUser(LoginUser event, Emitter emit) async{
  emit(Loading());
  
  try{

    await AppMatrix.client.login(
      LoginType.mLoginPassword,
      identifier: AuthenticationUserIdentifier(user: event.username),
      password: event.password
    );

    AppMatrix.clientId = AppMatrix.client.userID;
    AppMatrix.clientLogo = await AppMatrix.client.getAvatarUrl(AppMatrix.clientId!);

    emit(LoginSuccess());

  }catch(e){
    emit(Failure(message: e is MatrixException ? e.errorMessage : e.toString()));
  }
}

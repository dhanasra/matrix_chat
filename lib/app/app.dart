

import 'package:flutter/material.dart';
import 'package:instrive_chat/app/app_routes.dart';
import 'package:instrive_chat/app/app_style.dart';
import 'package:matrix/matrix.dart';

class App extends StatelessWidget {
  final List<Client>? clients;

  const App({
    super.key,
    this.clients
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: getInitialRoute(),
      onGenerateRoute: Routes.getPages,
      theme: AppStyle.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }

  String getInitialRoute(){
    return clients?.any((client) => client.isLogged()) ?? false ? Routes.roomsPage : Routes.splashPage;
  }
}
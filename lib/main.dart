

import 'package:flutter/material.dart';
import 'package:instrive_chat/app/app.dart';
import 'package:instrive_chat/config/client_manager.dart';
import 'package:collection/collection.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final clients = await ClientManager.getClients();

  final firstClient = clients.firstOrNull;
  await firstClient?.roomsLoading;
  await firstClient?.accountDataLoading;

  runApp(const App());
}

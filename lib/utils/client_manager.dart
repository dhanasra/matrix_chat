import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:instrive_chat/app/app_config.dart';
import 'package:instrive_chat/db/local_storage.dart';
import 'package:instrive_chat/utils/platform_infos.dart';
import 'package:matrix/encryption/utils/key_verification.dart';
import 'package:matrix/matrix.dart';
import 'package:path_provider/path_provider.dart';

/*
 * Handling client creation and saving functions.
 */

abstract class ClientManager { 
  static const String clientNamespace = 'instrive.chat.store.clients';

  static Future<List<Client>> getClients({bool initialize = true}) async {
    
    if(PlatformInfos.isLinux){
      Hive.init((await getApplicationSupportDirectory()).path);
    }else {
      Hive.initFlutter();
    }

    final clientNames = <String>{};

    // Getting client names from local storage.
    try {
      final rawClientNames = await LocalStorage().getItem(clientNamespace);
      if (rawClientNames != null) {
        final clientNamesList =
            (jsonDecode(rawClientNames) as List).cast<String>();
        clientNames.addAll(clientNamesList);
      }
    } catch (e, s) {
      Logs().w('Client names in store are corrupted', e, s);
      await LocalStorage().deleteItem(clientNamespace);
    }

    if (clientNames.isEmpty) {
      clientNames.add(AppConfig.clientName);
      await LocalStorage().setItem(clientNamespace, jsonEncode(clientNames.toList()));
    }

    // Converting client names into Client Objects
    final clients = clientNames.map(createClient).toList();

    if (initialize) {
      await Future.wait(clients.map((client) => client
          .init(
            waitForFirstSync: false,
            waitUntilLoadCompletedLoaded: false,
          )
          .catchError(
              (e, s) => Logs().e('Unable to initialize client', e, s))));
    }

    // Removing clients which are logged out
    if (clients.length > 1 && clients.any((c) => !c.isLogged())) {
      final loggedOutClients = clients.where((c) => !c.isLogged()).toList();
      for (final client in loggedOutClients) {
        Logs().w(
            'Multi account is enabled but client ${client.userID} is not logged in. Removing...');
        clientNames.remove(client.clientName);
        clients.remove(client);
      }
      await LocalStorage().setItem(clientNamespace, jsonEncode(clientNames.toList()));
    }
    return clients;
  }

  // Add a new client name to local storage.
  static Future<void> addClientNameToStore(String clientName) async {
    final clientNamesList = <String>[];
    final rawClientNames = await LocalStorage().getItem(clientNamespace);
    if (rawClientNames != null) {
      final stored = (jsonDecode(rawClientNames) as List).cast<String>();
      clientNamesList.addAll(stored);
    }
    clientNamesList.add(clientName);
    await LocalStorage().setItem(clientNamespace, jsonEncode(clientNamesList));
  }

  // Remove a existing client name from local storage.
  static Future<void> removeClientNameFromStore(String clientName) async {
    final clientNamesList = <String>[];
    final rawClientNames = await LocalStorage().getItem(clientNamespace);
    if (rawClientNames != null) {
      final stored = (jsonDecode(rawClientNames) as List).cast<String>();
      clientNamesList.addAll(stored);
    }
    clientNamesList.remove(clientName);
    await LocalStorage().setItem(clientNamespace, jsonEncode(clientNamesList));
  }

  static NativeImplementations get nativeImplementations => kIsWeb
    ? const NativeImplementationsDummy()
    : NativeImplementationsIsolate(compute);

  // Creating client objects
  static Client createClient(String clientName) {
    return Client(
      clientName,
      logLevel: kReleaseMode ? Level.warning : Level.verbose,
      verificationMethods: {
        KeyVerificationMethod.numbers,
        if (kIsWeb || PlatformInfos.isMobile || PlatformInfos.isLinux)
          KeyVerificationMethod.emoji,
      },
      importantStateEvents: <String>{
        // To make room emotes work
        'im.ponies.room_emotes',
        // To check which story room we can post in
        EventTypes.RoomPowerLevels,
      },
      supportedLoginTypes: {
        AuthenticationTypes.password
      },
      nativeImplementations: nativeImplementations
    );
  }

}
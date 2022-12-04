
import 'package:matrix/matrix.dart';

import 'app_config.dart';
import 'client_manager.dart';

class AppMatrix {

  static Client client = ClientManager.createClient('${AppConfig.applicationName}-${DateTime.now().millisecondsSinceEpoch}');

  static String? roomId;

  static String? clientId;
  static Uri? clientLogo;
  static String? clientName;

}
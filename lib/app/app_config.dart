import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class AppConfig {
  
  static bool get isWeb => kIsWeb;

  static const String _applicationName = 'LetsChat';
  static String get applicationName => _applicationName;

  static const String _defaultBrowser = 'https://matrix.org';
  static String get defaultBrowser => _defaultBrowser;

  static String get clientName =>
      '${AppConfig.applicationName} ${isWeb ? 'web' : Platform.operatingSystem}${kReleaseMode ? '' : 'Debug'}';

}
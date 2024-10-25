import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

enum Platform { android, web, windows }

class PlatformOptions {
  static String? host;
  static int port = 9000;

  static PlatformOptions get currentPlatform {
    if (kIsWeb) {
      return PlatformOptions.web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return PlatformOptions.android;
      case TargetPlatform.windows:
        return PlatformOptions.windows;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for Linux.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static PlatformOptions web = PlatformOptions._setOptions(
    host: "127.0.0.1",
    port: port,
  );

  // Cấu hình cho nền tảng Android
  static PlatformOptions android = PlatformOptions._setOptions(
    host: "10.0.2.2",
    port: port,
  );

  // Cấu hình cho nền tảng Windows
  static PlatformOptions windows = PlatformOptions._setOptions(
    host: "127.0.0.1",
    port: port,
  );

  PlatformOptions._setOptions({
    required String? host,
    required int port,
  }) {
    PlatformOptions.host = host;
    PlatformOptions.port = port;
  }
}

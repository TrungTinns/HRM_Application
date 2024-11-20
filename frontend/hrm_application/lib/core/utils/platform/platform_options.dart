import 'dart:io';
import 'package:flutter/foundation.dart';

class PlatformOptions {
  static String? host;
  static int port = 9000;

  // Cấu hình cho nền tảng Web
  static final PlatformOptions web = PlatformOptions._setOptions(
    host: '127.0.0.1',
    port: port,
  );

  // Cấu hình cho nền tảng Android
  static final PlatformOptions android = PlatformOptions._setOptions(
    host: '10.0.2.2',
    port: port,
  );

  // Cấu hình cho nền tảng Windows
  static final PlatformOptions windows = PlatformOptions._setOptions(
    host: '127.0.0.1',
    port: port,
  );

  // Thiết lập các giá trị host và port
  PlatformOptions._setOptions({
    required String host,
    required int port,
  }) {
    PlatformOptions.host = host;
    PlatformOptions.port = port;
  }

  // Lấy cấu hình cho nền tảng hiện tại
  static PlatformOptions get currentPlatform {
    if (kIsWeb) {
      return PlatformOptions.web;
    } else if (Platform.isAndroid) {
      return PlatformOptions.android;
    } else if (Platform.isWindows) {
      return PlatformOptions.windows;
    } else {
      throw UnsupportedError("Platform không được hỗ trợ");
    }
  }
}

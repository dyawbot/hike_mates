import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class Config {
  static const MethodChannel _channel =
      MethodChannel("com.example.hike_mates/config");

  static Future<String?> getStyleKey() async {
    final logger = Logger();

    final String? styleKey = await _channel.invokeMethod('getStyleKey');
    logger.d(styleKey);
    return styleKey;
  }
}

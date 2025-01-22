import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_feature_printer_platform_interface.dart';

/// An implementation of [FlutterFeaturePrinterPlatform] that uses method channels.
class MethodChannelFlutterFeaturePrinter extends FlutterFeaturePrinterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_feature_printer');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

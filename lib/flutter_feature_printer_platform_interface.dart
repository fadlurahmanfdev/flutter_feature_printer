import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_feature_printer_method_channel.dart';

abstract class FlutterFeaturePrinterPlatform extends PlatformInterface {
  /// Constructs a FlutterFeaturePrinterPlatform.
  FlutterFeaturePrinterPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterFeaturePrinterPlatform _instance = MethodChannelFlutterFeaturePrinter();

  /// The default instance of [FlutterFeaturePrinterPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterFeaturePrinter].
  static FlutterFeaturePrinterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterFeaturePrinterPlatform] when
  /// they register themselves.
  static set instance(FlutterFeaturePrinterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

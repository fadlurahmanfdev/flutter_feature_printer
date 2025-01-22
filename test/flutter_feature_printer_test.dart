import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_feature_printer/flutter_feature_printer.dart';
import 'package:flutter_feature_printer/flutter_feature_printer_platform_interface.dart';
import 'package:flutter_feature_printer/flutter_feature_printer_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterFeaturePrinterPlatform
    with MockPlatformInterfaceMixin
    implements FlutterFeaturePrinterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterFeaturePrinterPlatform initialPlatform = FlutterFeaturePrinterPlatform.instance;

  test('$MethodChannelFlutterFeaturePrinter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterFeaturePrinter>());
  });

  test('getPlatformVersion', () async {
    FlutterFeaturePrinter flutterFeaturePrinterPlugin = FlutterFeaturePrinter();
    MockFlutterFeaturePrinterPlatform fakePlatform = MockFlutterFeaturePrinterPlatform();
    FlutterFeaturePrinterPlatform.instance = fakePlatform;

    expect(await flutterFeaturePrinterPlugin.getPlatformVersion(), '42');
  });
}

export 'src/data/repository/feature_thermal_printer_repository.dart';
export 'src/feature_thermal_printer.dart';
import 'flutter_feature_printer_platform_interface.dart';

class FlutterFeaturePrinter {
  Future<String?> getPlatformVersion() {
    return FlutterFeaturePrinterPlatform.instance.getPlatformVersion();
  }
}

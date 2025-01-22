import 'package:flutter_feature_printer/src/data/repository/feature_sunmi_printer_repository.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_qrcode_style.dart';
import 'package:sunmi_printer_plus/core/styles/sunmi_text_style.dart';
import 'package:sunmi_printer_plus/core/types/sunmi_column.dart';
import 'package:sunmi_printer_plus/core/types/sunmi_text.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class FeatureSunmiPrinterRepositoryImpl extends FeatureSunmiPrinterRepository {
  final sunmiPrinterPlus = SunmiPrinterPlus();

  /// Get the printer version
  Future<String?> get version => sunmiPrinterPlus.getVersion();

  /// Get the unique identifier of the printer
  Future<String?> get id => sunmiPrinterPlus.getId();

  /// Get the status of the paper
  Future<String?> get paperStatus => sunmiPrinterPlus.getPaper();

  /// Get the platform version of the printer
  Future<String?> get platformVersion => sunmiPrinterPlus.getPlatformVersion();

  /// Get the current status of the printer
  Future<String?> get status => sunmiPrinterPlus.getStatus();

  /// Get type of printer
  Future<String?> get type => sunmiPrinterPlus.getType();

  /// Print text with configurable [SunmiTextStyle]
  Future<String?> printText({required String text, SunmiTextStyle? style}) {
    return sunmiPrinterPlus.printText(text: text, style: style);
  }

  /// Print custom text with parameter [SunmiText]
  Future<String?> printCustomText({required SunmiText text}) {
    return sunmiPrinterPlus.printCustomText(sunmiText: text);
  }

  /// Print custom row
  Future<String?> printRow({required List<SunmiColumn> cols}) {
    return sunmiPrinterPlus.printRow(cols: cols);
  }

  /// Print using esc pos generator
  Future<String?> printEscPos(List<int> data) {
    return sunmiPrinterPlus.printEscPos(data);
  }

  /// Print QR Code
  Future<String?> printQrcode({required String text, SunmiQrcodeStyle? style}) {
    return sunmiPrinterPlus.printQrcode(text: text);
  }

  /// Print divider
  Future<String?> line({String type = 'solid'}) {
    return sunmiPrinterPlus.line(type: type);
  }

  /// line break
  Future<String?> lineWrap({int times = 1}) {
    return sunmiPrinterPlus.lineWrap(times: times);
  }
}

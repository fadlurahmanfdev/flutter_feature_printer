import 'dart:developer';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter_feature_printer/src/data/repository/feature_thermal_printer_repository.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class FeatureThermalPrinter extends FeatureThermalPrinterRepository {
  String? _connectedMacAddress;

  /// Get the connected mac address printer
  @override
  String? get connectedMacAddress => _connectedMacAddress;

  /// Detect if bluetooth is turned on
  @override
  Future<bool> get isBluetoothEnabled => PrintBluetoothThermal.bluetoothEnabled;

  /// Check whether bluetooth permission granted
  @override
  Future<bool> get isBluetoothPermissionGranted => PrintBluetoothThermal.isPermissionBluetoothGranted;

  /// Check whether the printer is connected
  @override
  Future<bool> get isConnectedToPrinter => PrintBluetoothThermal.connectionStatus;

  /// Get the percentage of the battery returns int
  @override
  Future<int> get batteryLevel => PrintBluetoothThermal.batteryLevel;

  /// Android: Return all paired bluetooth on the device,
  /// IOS: Return nearby bluetooths
  @override
  Future<List<BluetoothInfo>> get pairedBluetoothDevices => PrintBluetoothThermal.pairedBluetooths;

  /// Create a generator for creating printer content tools
  @override
  Future<Generator> createGenerator({required PaperSize paperSize}) async {
    final profile = await CapabilityProfile.load();
    return Generator(paperSize, profile);
  }

  /// Connect with the bluetooth printer
  @override
  Future<bool> connect({required String macPrinterAddress}) async {
    try {
      if (await isConnectedToPrinter && connectedMacAddress == macPrinterAddress) {
        log("already connected to printer $macPrinterAddress");
        return true;
      }
      final isConnected = await PrintBluetoothThermal.connect(macPrinterAddress: macPrinterAddress);
      if (isConnected) {
        _connectedMacAddress = macPrinterAddress;
        return true;
      }

      _connectedMacAddress = null;
      return false;
    } catch (e, s) {
      log("failed connect with $macPrinterAddress", error: e, stackTrace: s);
      _connectedMacAddress = null;
      return false;
    }
  }

  /// Disconnect with the bluetooth printer
  @override
  Future<bool> disconnect() {
    return PrintBluetoothThermal.disconnect;
  }

  /// Print content of text that converted into bytes
  @override
  Future<bool> printBytes(List<int> text) async {
    try {
      return PrintBluetoothThermal.writeBytes(text);
    } catch (e, s) {
      log("failed print bytes", error: e, stackTrace: s);
      return false;
    }
  }

  /// Print content of text
  @override
  Future<bool> printText(PrintTextSize text) async {
    try {
      return PrintBluetoothThermal.writeString(printText: text);
    } catch (e, s) {
      log("failed print text", error: e, stackTrace: s);
      return false;
    }
  }
}

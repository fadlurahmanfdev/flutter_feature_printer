import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

abstract class FeatureThermalPrinterRepository {
  /// Connected printer mac address
  /// return null if there is no connected printer
  String? get connectedMacAddress;
  /// Detect if bluetooth is turned on
  Future<bool> get isBluetoothEnabled;
  /// Check whether bluetooth permission granted
  Future<bool> get isBluetoothPermissionGranted;
  /// Check whether the printer is connected
  Future<bool> get isConnectedToPrinter;
  /// Get the percentage of the battery returns int
  Future<int> get batteryLevel;
  /// Android: Return all paired bluetooth on the device,
  /// IOS: Return nearby bluetooths
  Future<List<BluetoothInfo>> get pairedBluetoothDevices;
  /// Create a generator for creating printer content tools
  Future<Generator> createGenerator({required PaperSize paperSize});
  /// Connect with the bluetooth printer
  Future<bool> connect({required String macPrinterAddress});
  /// Disconnect with the bluetooth printer
  Future<bool> disconnect();
  /// Print content of text that converted into bytes
  Future<bool> printBytes(List<int> text);
  /// Print content of text
  Future<bool> printText(PrintTextSize text);
}
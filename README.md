# Description

Flutter library to handle printer (thermal, esc, pos).

## Key Features

### Thermal / ESC POS Printer

#### Bluetooth Permission

Check whether bluetooth permission granted

```dart
final thermalPrinter = FeatureThermalPrinter();
Future<void> screenFunction() async {
  final isBluetoothPermissionGranted = await thermalPrinter.isBluetoothPermissionGranted;
  // process bluetooth permission
}
```

#### Bluetooth Service Enabled

Check whether bluetooth service enabled

```dart
final thermalPrinter = FeatureThermalPrinter();
Future<void> screenFunction() async {
  final isBluetoothEnabled = await thermalPrinter.isBluetoothEnabled;
  // process bluetooth service
}
```

#### Check Printer Connection

Check whether already connected to printer

```dart
final thermalPrinter = FeatureThermalPrinter();
Future<void> screenFunction() async {
  final isConnectedToPrinter = await thermalPrinter.isConnectedToPrinter;
  // process connected printer
}
```

Check connected mac address printer

```dart
final thermalPrinter = FeatureThermalPrinter();
Future<void> screenFunction() async {
  final connectedMacAddress = thermalPrinter.connectedMacAddress;
  // process connected mac address printer
}
```

#### Check paired bluetooth devices

Fetch paired bluetooth devices

```dart
final thermalPrinter = FeatureThermalPrinter();
Future<void> screenFunction() async {
  final bluetoothDevices = await thermalPrinter.pairedBluetoothDevices;
  // process bluetooth devices
}
```

#### Connect or Disconnect to Printer

Connect to printer using mac address get from get paired bluetooth devices

```dart
final thermalPrinter = FeatureThermalPrinter();
Future<void> screenFunction() async {
  final isConnected = await thermalPrinter.connect(macPrinterAddress: '{mac_printer_address}');
  // process connected printer
}
```

Disconnect to printer

```dart
final thermalPrinter = FeatureThermalPrinter();
Future<void> screenFunction() async {
  await thermalPrinter.disconnect();
  // process disconnected printer
}
```

#### Print content

Print content using bytes

```dart
final thermalPrinter = FeatureThermalPrinter();
Future<void> screenFunction() async {
  final content = await customContent();
  await thermalPrinter.printBytes(content);
}

Future<List<int>> customContent() async {
  final generator = await thermalPrinter.createGenerator(paperSize: PaperSize.mm58);
  List<int> bytes = [];

  bytes += generator.text(
    'Taufik Fadlurahman Fajari',
    styles: PosStyles(
      align: PosAlign.center,
    ),
  );
  bytes += generator.text(
    'Jakarta Selatan, Indonesia',
    styles: PosStyles(
      align: PosAlign.center,
    ),
  );
  bytes += generator.feed(1);
  bytes += generator.hr(ch: "=");
  bytes += generator.feed(1);

  bytes += generator.row([
    PosColumn(
      text: '1',
      width: 1,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'Ayam Madura',
      width: 8,
      styles: const PosStyles(align: PosAlign.left, underline: true),
    ),
    PosColumn(
      text: '28.000',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);
  bytes += generator.row([
    PosColumn(
      text: '1',
      width: 1,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'Nasi Goreng',
      width: 8,
      styles: const PosStyles(align: PosAlign.left, underline: true),
    ),
    PosColumn(
      text: '15.000',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);

  bytes += generator.row([
    PosColumn(
      text: '1',
      width: 1,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'Thai Tea',
      width: 8,
      styles: const PosStyles(align: PosAlign.left, underline: true),
    ),
    PosColumn(
      text: '22.000',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);
  bytes += generator.row([
    PosColumn(
      text: '1',
      width: 1,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'Es Tebu',
      width: 8,
      styles: const PosStyles(align: PosAlign.left, underline: true),
    ),
    PosColumn(
      text: '16.000',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);
  bytes += generator.hr();
  bytes += generator.row([
    PosColumn(
      text: ' ',
      width: 1,
      styles: const PosStyles(align: PosAlign.center),
    ),
    PosColumn(
      text: 'Total',
      width: 8,
      styles: const PosStyles(align: PosAlign.left, underline: true),
    ),
    PosColumn(
      text: '81.000',
      width: 3,
      styles: const PosStyles(align: PosAlign.center, underline: true, bold: true),
    ),
  ]);

  bytes += generator.feed(1);
  bytes += generator.hr();
  bytes += generator.text(
    'T H A N K  Y O U',
    styles: PosStyles(
      align: PosAlign.center,
    ),
  );
  bytes += generator.feed(1);
  bytes += generator.qrcode(
    'https://www.linkedin.com/in/taufikfadlurahmanfajari/',
    align: PosAlign.center,
  );
  bytes += generator.feed(1);
  bytes += generator.cut();
  return bytes;
}
```




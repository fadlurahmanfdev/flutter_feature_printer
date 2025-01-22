import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feature_printer/esc_pos_utils_plus.dart';
import 'package:flutter_feature_printer/flutter_feature_printer.dart';
import 'package:flutter_feature_printer_example/data/dto/model/feature_model.dart';

import 'presentation/widget/feature_widget.dart';
import 'package:image/image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Feature Printer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Feature Printer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FeatureThermalPrinterRepository thermalPrinter;
  List<FeatureModel> features = [
    FeatureModel(
      title: 'Is Bluetooth Permission Granted',
      desc: 'Check whether bluetooth permission granted',
      key: 'IS_BLUETOOTH_PERMISSION_GRANTED',
    ),
    FeatureModel(
      title: 'Is Bluetooth Enabled',
      desc: 'Check whether bluetooth enabled',
      key: 'IS_BLUETOOTH_ENABLED',
    ),
    FeatureModel(
      title: 'Check Printer Connection Status',
      desc: 'Check Printer Connection Status',
      key: 'CHECK_CONNECTION_STATUS',
    ),
    FeatureModel(
      title: 'Check List Paired Bluetooth',
      desc: 'Check List Paired Bluetooth',
      key: 'LIST_PAIRED_BLUETOOTH',
    ),
    FeatureModel(
      title: 'Check Connected Mac Address Printer',
      desc: 'Check Connected Mac Address Printer',
      key: 'CONNECTED_PRINTER_MAC_ADDRESS',
    ),
    FeatureModel(
      title: 'Connect With Printer Thermal',
      desc: 'Connect With Printer Thermal',
      key: 'CONNECT',
    ),
    FeatureModel(
      title: 'Disconnect With Printer Thermal',
      desc: 'Disconnect With Printer Thermal',
      key: 'DISCONNECT',
    ),
    FeatureModel(
      title: 'Print Using Bytes',
      desc: 'Print Using Bytes',
      key: 'PRINT_USING_BYTES',
    ),
    FeatureModel(
      title: 'Print Asset Image',
      desc: 'Print Asset Image',
      key: 'PRINT_ASSET_IMAGE',
    ),
  ];

  @override
  void initState() {
    super.initState();
    thermalPrinter = FeatureThermalPrinter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biometric')),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: features.length,
        itemBuilder: (_, index) {
          final feature = features[index];
          return GestureDetector(
            onTap: () async {
              switch (feature.key) {
                case "IS_BLUETOOTH_PERMISSION_GRANTED":
                  final isBluetoothPermissionGranted = await thermalPrinter.isBluetoothPermissionGranted;
                  log("is bluetooth permission granted: $isBluetoothPermissionGranted");
                  break;
                case "IS_BLUETOOTH_ENABLED":
                  final isBluetoothEnabled = await thermalPrinter.isBluetoothEnabled;
                  log("is bluetooth enabled: $isBluetoothEnabled");
                  break;
                case "CHECK_CONNECTION_STATUS":
                  final isConnected = await thermalPrinter.isConnectedToPrinter;
                  log("is connected: $isConnected");
                  break;
                case "LIST_PAIRED_BLUETOOTH":
                  final pairedBluetooth = await thermalPrinter.pairedBluetoothDevices;
                  log("total paired bluetooth: ${pairedBluetooth.length}");
                  for (final info in pairedBluetooth) {
                    log("bluetooh info: ${info.name}, mac address: ${info.macAdress}");
                  }
                  break;
                case "CONNECTED_PRINTER_MAC_ADDRESS":
                  final macAddress = thermalPrinter.connectedMacAddress;
                  log("connected mac address printer: $macAddress");
                  break;
                case "CONNECT":
                  final isConnected = await thermalPrinter.connect(macPrinterAddress: "DC:0D:51:F5:7E:AD");
                  log("is connected: $isConnected");
                  break;
                case "DISCONNECT":
                  final isConnected = await thermalPrinter.disconnect();
                  log("is connected: $isConnected");
                  break;
                case "PRINT_USING_BYTES":
                  final content = await customContent();
                  final result = await thermalPrinter.printBytes(content);
                  log("result: $result");
                  break;
                case "PRINT_ASSET_IMAGE":
                  final content = await assetImage();
                  thermalPrinter.printBytes(content);
                  break;
              }
            },
            child: ItemFeatureWidget(feature: feature),
          );
        },
      ),
    );
  }

  Future<List<int>> getDummyByteForPrint() async {
    final generator = await thermalPrinter.createGenerator(paperSize: PaperSize.mm58);
    List<int> bytes = [];

    bytes += generator.text('Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ', styles: const PosStyles(codeTable: 'CP1252'));
    bytes += generator.text('Special 2: blåbærgrød', styles: const PosStyles(codeTable: 'CP1252'));

    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes += generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text', styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left', styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center', styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right', styles: const PosStyles(align: PosAlign.right), linesAfter: 1);

    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    // Print barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));

    bytes += generator.feed(2);
    bytes += generator.cut();
    return bytes;
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
      '+6281283602320',
      styles: PosStyles(
        align: PosAlign.center,
      ),
    );
    bytes += generator.text(
      'taufikfadlurahmanfajari.dev@gmail.com',
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

  Future<List<int>> assetImage() async {
    final generator = await thermalPrinter.createGenerator(paperSize: PaperSize.mm58);
    List<int> bytes = [];
    
    final assetImage = await rootBundle.load('images/flutter_logo.png');
    final imageBytes = assetImage.buffer.asUint8List();
    final originalImage = decodeImage(imageBytes);
    final double aspectRatio = originalImage!.width / originalImage.height;
    final int newHeight = (240 / aspectRatio).round();
    final resizedImage = copyResize(
      originalImage,
      width: 240,
      height: newHeight,
      interpolation: Interpolation.linear,
    );
    final grayscaleImg = grayscale(resizedImage);
    final bwImage = contrast(grayscaleImg, contrast: 50);
    bytes += generator.image(bwImage);

    bytes += generator.cut();
    
    return bytes;
  }
}

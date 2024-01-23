import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: must_be_immutable
class UserScanReceipt extends StatefulWidget {
  UserScanReceipt({super.key});

  @override
  State<UserScanReceipt> createState() => _UserScanReceiptState();
}

class _UserScanReceiptState extends State<UserScanReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Scan"),
        centerTitle: true,
      ),
    );
  }
}

class QRCodeWidget extends StatefulWidget {
  const QRCodeWidget({Key? key}) : super(key: key);

  @override
  State<QRCodeWidget> createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  String result = "";

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData.code!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan Receipt"),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              )),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "Scan Result:  $result",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

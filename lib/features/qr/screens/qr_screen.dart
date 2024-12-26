import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_user_app/common/custom_app_bar.dart';
import 'package:library_user_app/common/custom_button.dart';
import 'package:library_user_app/features/book/controller/book_controller.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _showRescanButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      String barcode = scanData.code!;

      try {
        bool success = await Get.find<BookController>().borrowBook(barcode: barcode);
        if (!success) {
          setState(() {
            _showRescanButton = true;
          });
        }
      } catch (e) {
        setState(() {
          _showRescanButton = true;
        });
      }
    });
  }

  void _rescan() {
    controller?.resumeCamera();
    setState(() {
      _showRescanButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Scan Barcode to Borrow Book', backButton: false),
      body: Column(children: [
        Expanded(
          flex: 5,
          child: QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
        ),

        if (_showRescanButton)
          Expanded(
            flex: 1,
            child: Center(
              child: CustomButton(
                width: 200,
                text: 'ReScan',
                onTap: _rescan,
              ),
            ),
          ),
      ]),
    );
  }
}

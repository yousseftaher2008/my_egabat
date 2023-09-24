//TODO: Compelete the qr code view and fix the late init error
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_egabat/app/modules/home/student_home/controllers/student_home_controller.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../core/constants/screen_dimensions.dart';
import '../../../../../core/constants/styles/colors.dart';

class QrCodeScreen extends GetView<StudentHomeController> {
  const QrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar screenAppBar = AppBar(
      backgroundColor: primaryColor,
      title: const Text("QR Code"),
    );
    double qrCodeDimensions = min(pageHeight(), pageWidth() - 100);
    double heightWithoutQrCode = ((pageHeight() -
                MediaQuery.of(context).padding.top -
                screenAppBar.preferredSize.height) -
            qrCodeDimensions) /
        2;
    Color pageColor = Colors.black.withOpacity(0.5);
    final GlobalKey qrView = GlobalKey();
    return Scaffold(
      appBar: screenAppBar,
      body: Stack(
        children: [
          Center(
            child: QRView(key: qrView, onQRViewCreated: controller.checkQrCode),
          ),
          Container(
            color: pageColor,
            width: double.infinity,
            height: heightWithoutQrCode,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: pageColor,
              width: double.infinity,
              height: heightWithoutQrCode,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              color: pageColor,
              width: 50,
              height: qrCodeDimensions,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              color: pageColor,
              width: 50,
              height: qrCodeDimensions,
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: primaryColor,
                  width: 4,
                ),
              ),
              height: qrCodeDimensions + 10,
              width: qrCodeDimensions + 10,
            ),
          ),
        ],
      ),
    );
  }
}

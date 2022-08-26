import 'package:flutter/material.dart';
import 'package:Fanshop/custom/custom_appbar.dart';
import 'package:barcode_widget/barcode_widget.dart';

// ignore: must_be_immutable
class QrcodePage extends StatelessWidget {
  int id;
  String name;
  QrcodePage({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        name,
        Theme.of(context).primaryColor,
      ),
      body: Center(
        child: BarcodeWidget(
          barcode: Barcode.qrCode(), // Barcode type and settings
          data: 'http://43.138.203.36:8086/flutter/#/', // Content
          width: 200,
          height: 200,
          color: Theme.of(context).primaryColor, // 二维码颜色
          errorBuilder: (context, error) => Center(child: Text(error)),
        ),
      ),
    );
  }
}

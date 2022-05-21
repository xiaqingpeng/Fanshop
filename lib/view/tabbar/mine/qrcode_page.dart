import 'package:flutter/material.dart';
import 'package:Fanshop/custom/custom_appbar.dart';

import 'package:qr_flutter/qr_flutter.dart';

// ignore: must_be_immutable
class QrcodePage extends StatelessWidget {
  int id;
  String name;
  QrcodePage({required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        name,
        Theme.of(context).primaryColor,
      ),
      body: Center(
        child: QrImage(
          data: 'http://43.138.203.36:8086/flutter',
          size: 200,
          embeddedImage: const NetworkImage(
              'https://img2.woyaogexing.com/2019/09/06/f9afde08c5a4460cb08389a6c7f74c7a!600x600.jpeg'),
          embeddedImageStyle: QrEmbeddedImageStyle(
            size: const Size(50, 50),
          ),
        ),
      ),
    );
  }
}

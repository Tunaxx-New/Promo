import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Future<Uint8List> captureQr(GlobalKey qrKey) async {
  final boundary =
      qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  final image = await boundary.toImage(pixelRatio: 3);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}

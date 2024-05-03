import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class SkinHead extends StatefulWidget {
  final String skinImageUrl;

  const SkinHead({super.key, required this.skinImageUrl});

  @override
  _SkinHeadState createState() => _SkinHeadState();
}

class _SkinHeadState extends State<SkinHead> {
  Uint8List? _headImage;

  @override
  void initState() {
    super.initState();
    _loadHeadImage();
  }

  Future<void> _loadHeadImage() async {
    // Загружаем изображение скина
    final ByteData data = await NetworkAssetBundle(Uri.parse(widget.skinImageUrl)).load("");
    final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final ui.FrameInfo fi = await codec.getNextFrame();

    // Получаем объект ui.Image из FrameInfo
    final ui.Image skinImage = fi.image;

    // Получаем объект ByteData из ui.Image
    final ByteData? skinByteData = await skinImage.toByteData(format: ui.ImageByteFormat.png);

    // Проверяем, что ByteData не равен null
    if (skinByteData != null) {
      // Создаем Uint8List из ByteData
      Uint8List skinUint8List = skinByteData.buffer.asUint8List();
      setState(() {
        // Сохраняем Uint8List для использования в Image.memory
        _headImage = skinUint8List;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: _headImage != null ? Image.memory(_headImage!).image : const NetworkImage(
        "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.behance.net%2Fgallery%2F67094899%2FMinecraft-Avatars&psig=AOvVaw19l_4hy49ajyASn9cI5R5I&ust=1714334807278000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCPi2o_uY44UDFQAAAAAdAAAAABAE",
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Future<ui.Image> copyCrop(ui.Image originalImage, int x, int y, int w, int h) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    final Paint paint = Paint();
    final Rect src = Rect.fromLTWH(x.toDouble(), y.toDouble(), w.toDouble(), h.toDouble());
    final Rect dst = Rect.fromLTWH(0.0, 0.0, w.toDouble(), h.toDouble());
    canvas.drawImageRect(originalImage, src, dst, paint);
    final ui.Picture picture = recorder.endRecording();
    return picture.toImage(w, h);
  }
}
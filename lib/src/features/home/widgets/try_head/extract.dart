// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;
// import 'package:image/image.dart' as img;
// import 'package:http/http.dart' as http;
//
// Future<img.Image> loadImage(String url) async {
//   final response = await http.get(Uri.parse(url));
//   if (response.statusCode == 200) {
//     return img.decodeImage(response.bodyBytes)!;
//   } else {
//     throw Exception('Failed to load skin image');
//   }
// }
//
// Future<ui.Image> convertImageToUiImage(img.Image image) async {
//   final completer = Completer<ui.Image>();
//   ui.decodeImageFromList(img.encodePng(image), (result) {
//     completer.complete(result);
//   });
//   return completer.future;
// }
//
// img.Image extractSection(img.Image image, int x, int y, int width, int height) {
//   return img.copyCrop(image, x:x, y:y, width: width, height: height);
// }
//
// img.Image createAvatarImage(img.Image skinImage) {
//   // На основе размера скина мы определяем, какой части его нужно использовать
//   // Здесь приведен пример только для головы
//   img.Image head = extractSection(skinImage, 8, 8, 8, 8); // координаты для головы
//
//   // Создаем полный рендер аватара с использованием только головы
//   img.Image avatarImage = img.Image(width: 8, height: 8); // Создаем пустое изображение для аватара
//   avatarImage = img.compositeImage(avatarImage, head, dstX: 8, dstY: 8); // Вставляем голову без смешивания
//
//   return avatarImage;
// }
//
// class AvatarWidget extends StatelessWidget {
//   final ui.Image avatarImage;
//
//   const AvatarWidget({super.key, required this.avatarImage});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: AvatarPainter(avatarImage),
//     );
//   }
// }
//
// class AvatarPainter extends CustomPainter {
//   final ui.Image avatarImage;
//
//   AvatarPainter(this.avatarImage);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     canvas.drawImage(avatarImage, Offset.zero, Paint());
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// class MinecraftAvatar extends StatefulWidget {
//
//   const MinecraftAvatar({super.key});
//
//   @override
//   State<MinecraftAvatar> createState() => _MinecraftAvatarState();
// }
//
// class _MinecraftAvatarState extends State<MinecraftAvatar> {
//   final String skinUrl = "http://kissota.ru:9000/skins/koliy82.png";
//
//   @override
//   Widget build(BuildContext context) {
//         return FutureBuilder<img.Image>(
//           future: loadImage(skinUrl),
//           builder: (BuildContext context, AsyncSnapshot<img.Image> snapshot) {
//             if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
//               // Конвертируем img.Image в ui.Image для рендеринга на Canvas
//               return FutureBuilder<ui.Image>(
//                 future: convertImageToUiImage(createAvatarImage(snapshot.data!)),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
//                     // Создаем виджет AvatarWidget с загруженным изображением
//                     print(snapshot.data);
//                     return Center(
//                       child: AvatarWidget(avatarImage: snapshot.data!),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         );
//   }
// }

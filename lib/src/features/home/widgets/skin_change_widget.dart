import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';

class SkinChangeWidget extends StatefulWidget {
  const SkinChangeWidget({super.key, required this.data});
  final UserData data;

  @override
  State<SkinChangeWidget> createState() => _SkinChangeWidgetState();
}

class _SkinChangeWidgetState extends State<SkinChangeWidget> {
  var dio = Dio();
  Widget? firstUploadedSkin;
  Widget? secondUploadedSkin;
  Widget? uploadedCloak;

  Widget firstUpdatedSkinImage() {
    firstUploadedSkin ??= Image.network(
      "http://kissota.ru:9000/skins/render/fullbodyiso/${widget.data.profile?.username ?? "koliy82"}.png",
      errorBuilder: (context, error, stackTrace) {
        return Column(
          children: [
            const Text("Нет скина"),
            const SizedBox(height: 8),
            Image.asset("assets/error_skin.png")
          ],
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      fit: BoxFit.fitWidth,
    );
    return firstUploadedSkin!;
  }

  Widget secondUpdatedSkinImage() {
    secondUploadedSkin ??= Image.network(
      "http://kissota.ru:9000/skins/render/fullbody/${widget.data.profile?.username ?? "koliy82"}.png",
      errorBuilder: (context, error, stackTrace) {
        return Column(
          children: [
            const Text("Нет скина"),
            const SizedBox(height: 8),
            Image.asset("assets/error_skin.png")
          ],
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      fit: BoxFit.fitWidth,
    );
    return secondUploadedSkin!;
  }

  Widget updatedCloakImage() {
    uploadedCloak ??= Image.network(
      "http://kissota.ru:9000/cloaks/${widget.data.profile?.username ?? "koliy82"}.png",
      errorBuilder: (context, error, stackTrace) {
        return const Column(
          children: [
            Text("Нет плаща"),
            SizedBox(height: 8),
            // Image.asset("assets/default_cape.png")
          ],
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      fit: BoxFit.fitWidth,
    );
    return uploadedCloak!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: 256,
                  width: 128,
                  child: firstUpdatedSkinImage(),
                ),
                SizedBox(
                  height: 256,
                  width: 128,
                  child: secondUpdatedSkinImage(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => uploadFile("skins"),
          child: const Text("Обновить скин"),
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 2),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 128,
              width: 128,
              child: updatedCloakImage(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => uploadFile("cloaks"),
          child: const Text("Обновить плащ"),
        ),
      ],
    );
  }

  Future<void> uploadFile(String path) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png'],
    );
    if (result != null) {
      firstUploadedSkin = const CircularProgressIndicator();
      secondUploadedSkin = const CircularProgressIndicator();
      var pFile = result.files.single;
      File file = File(pFile.path!);
      if (!file.path.endsWith(".png")) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Только изображения .png'),
            ),
          );
        return;
      }
      if (pFile.size > (1000000 * 30)) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Максимальный размер файла 30MB'),
            ),
          );
        return;
      }
      var response = await dio.post(
        "http://kissota.ru:9000/$path/${widget.data.profile!.username}.png",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            print(status.toString());
            var message = switch (status) {
              200 => null,
              400 => 'Ошибка при обработке запроса',
              500 => 'Ошибка обработки изображения со стороны сервера',
              _ => 'Неизвестная ошибка'
            };
            if (message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            }
            return true;
          },
        ),
        data: FormData.fromMap({
          "file": await MultipartFile.fromFile(
            file.path,
            filename: widget.data.profile!.username,
            contentType: MediaType('image', 'png'),
          ),
        }),
      );

      if (response.statusCode == 200) {
        if (path == "skins") {
          try {
            Uint8List firstSkinBytes = (await NetworkAssetBundle(Uri.parse(
                        "http://kissota.ru:9000/skins/render/fullbodyiso/${widget.data.profile?.username ?? "koliy82"}.png"))
                    .load(
                        "http://kissota.ru:9000/skins/render/fullbodyiso/${widget.data.profile?.username ?? "koliy82"}.png"))
                .buffer
                .asUint8List();
            Uint8List secondSkinBytes = (await NetworkAssetBundle(Uri.parse(
                        "http://kissota.ru:9000/skins/render/fullbody/${widget.data.profile?.username ?? "koliy82"}.png"))
                    .load(
                        "http://kissota.ru:9000/skins/render/fullbody/${widget.data.profile?.username ?? "koliy82"}.png"))
                .buffer
                .asUint8List();
            Uint8List avatarBytes = (await NetworkAssetBundle(Uri.parse(
                        "http://kissota.ru:9000/skins/render/face/${widget.data.profile?.username ?? "koliy82"}.png"))
                    .load(
                        "http://kissota.ru:9000/skins/render/face/${widget.data.profile?.username ?? "koliy82"}.png"))
                .buffer
                .asUint8List();

            firstUploadedSkin = Image.memory(firstSkinBytes);
            secondUploadedSkin = Image.memory(secondSkinBytes);
          } catch (e) {
            firstUploadedSkin = null;
            secondUploadedSkin = null;
          }
        } else {
          uploadedCloak = Image.file(file);
        }
      } else {
        if (path == "skins") {
          firstUploadedSkin = null;
          secondUploadedSkin = null;
        } else {
          uploadedCloak = null;
        }
      }

      setState(() {});
    } else {
      // User canceled the picker
    }
  }
}

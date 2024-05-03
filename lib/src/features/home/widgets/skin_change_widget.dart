import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
  Widget? uploadedSkin;
  Widget? uploadedCloak;

  Widget updatedSkinImage() {
    uploadedSkin ??= Image.network(
      "http://kissota.ru:9000/skins/${widget.data.profile?.username}.png",
      errorBuilder: (context, error, stackTrace) {
        return Column(
          children: [
            const Text("No Skin"),
            const SizedBox(height: 8),
            Image.asset("assets/default_skin.png")
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
    return uploadedSkin!;
  }

  Widget updatedCloakImage() {
    uploadedCloak ??= Image.network(
      "http://kissota.ru:9000/cloaks/${widget.data.profile?.username}.png",
      errorBuilder: (context, error, stackTrace) {
        return Column(
          children: [
            const Text("No Cape"),
            const SizedBox(height: 8),
            Image.asset("assets/default_cape.png")
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 136,
                        width: 96,
                        child: updatedSkinImage(),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['png'],
                          );
                          if (result != null) {
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
                                    content:
                                        Text('Максимальный размер файла 30MB'),
                                  ),
                                );
                              return;
                            }

                            var response = await dio.post(
                              "http://kissota.ru:9000/skins/${widget.data.profile!.username}.png",
                              data: FormData.fromMap({
                                "file": await MultipartFile.fromFile(file.path,
                                    filename: widget.data.profile!.username,
                                    contentType: MediaType('image', 'png')),
                              }),
                            );

                            if (response.statusCode == 200) {
                              uploadedSkin = Image.file(file);
                            } else {
                              uploadedSkin = null;
                            }

                            setState(() {});
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: const Text("Обновить скин"),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      SizedBox(
                        height: 136,
                        width: 96,
                        child: updatedCloakImage(),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['png'],
                          );
                          if (result != null) {
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
                                    content:
                                        Text('Максимальный размер файла 30MB'),
                                  ),
                                );
                              return;
                            }
                            var response = await dio.post(
                              "http://kissota.ru:9000/cloaks/${widget.data.profile!.username}.png",
                              data: FormData.fromMap({
                                "file": await MultipartFile.fromFile(file.path,
                                    filename: widget.data.profile!.username,
                                    contentType: MediaType('image', 'png')),
                              }),
                            );

                            if (response.statusCode == 200) {
                              uploadedCloak = Image.file(file);
                            } else {
                              uploadedCloak = null;
                            }

                            setState(() {});
                          } else {
                            // User canceled the picker
                          }
                        },
                        child: const Text("Обновить плащ"),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

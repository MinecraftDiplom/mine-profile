import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mine_profile/src/core/utils/telegram_page.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';
import 'package:mine_profile/src/features/home/blocs/home/home_cubit.dart';

class SkinScreen extends StatefulWidget {
  const SkinScreen({super.key, required this.data});
  final UserData data;

  @override
  State<SkinScreen> createState() => _SkinScreenState();
}

class _SkinScreenState extends State<SkinScreen> {
  var dio = Dio();
  Widget? firstUploadedSkin;
  Widget? secondUploadedSkin;
  Widget? uploadedCloak;
  Widget? avatar;

  Widget firstUpdatedSkinImage() {
    firstUploadedSkin ??= Image.network(
      "http://kissota.ru:9000/skins/render/fullbodyiso/${widget.data.profile?.username ?? "koliy82"}",
      errorBuilder: (context, error, stackTrace) {
        return Image.asset("assets/error_skin.png");
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
      "http://kissota.ru:9000/skins/render/fullbody/${widget.data.profile?.username ?? "koliy82"}",
      errorBuilder: (context, error, stackTrace) {
        return Image.asset("assets/error_skin.png");
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
      "http://kissota.ru:9000/cloaks/${widget.data.profile?.username ?? "koliy82"}",
      errorBuilder: (context, error, stackTrace) {
        return Image.asset("assets/error_cape.png");
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

  Widget updatedAvatarImage() {
    avatar ??= Image.network(
      "http://kissota.ru:9000/skins/render/face/${widget.data.profile?.username ?? "koliy82"}",
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          width: 128,
          height: 128,
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) => Image.asset(
        "assets/default_avatar.png",
      ),
    );
    return avatar!;
  }

  @override
  void initState() {
    context.read<HomeCubit>().setDrawerSliding(true);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;
    return EasyRefresh(
      onRefresh: () => update(),
      onLoad: () async {},
      child: ListView(
        children: [
          ListTile(
            title: Text(data.profile?.username ?? "minecraft"),
            subtitle: Text("@${data.user?.username ?? "telegram"}"),
            leading: GestureDetector(
              child: updatedAvatarImage(),
              onTap: () => openTelegramPage(
                "https://t.me/${data.user?.username ?? "koliy822"}",
              ),
            ),
          ),
          const SizedBox(height: 8),
          Column(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => uploadFile("skins"),
                    child: const Text("Обновить"),
                  ),
                  ElevatedButton(
                    onPressed: () => removeFile("skins"),
                    child: Text(
                      "Удалить",
                      style: TextStyle(color: Colors.red.shade200),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(thickness: 2),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 196,
                    width: 128,
                    child: updatedCloakImage(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => uploadFile("cloaks"),
                    child: const Text("Обновить"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => removeFile("cloaks"),
                    child: Text(
                      "Удалить",
                      style: TextStyle(color: Colors.red.shade200),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> removeFile(String path) async {
    await dio.post(
      "http://kissota.ru:9000/$path/remove/${widget.data.profile!.username}",
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          var message = switch (status) {
            200 => 'Файл успешно удалён',
            400 => 'Ошибка при обработке запроса',
            404 => 'Файл уже удалён с сервера',
            500 => 'Ошибка обработки изображения со стороны сервера',
            _ => 'Неизвестная ошибка'
          };
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
          return true;
        },
      ),
    );
    update();
  }

  Future<void> update() async {
    try {
      Uint8List firstSkinBytes = (await NetworkAssetBundle(Uri.parse(
                  "http://kissota.ru:9000/skins/render/fullbodyiso/${widget.data.profile?.username ?? "koliy82"}"))
              .load(
                  "http://kissota.ru:9000/skins/render/fullbodyiso/${widget.data.profile?.username ?? "koliy82"}"))
          .buffer
          .asUint8List();
      Uint8List secondSkinBytes = (await NetworkAssetBundle(Uri.parse(
                  "http://kissota.ru:9000/skins/render/fullbody/${widget.data.profile?.username ?? "koliy82"}"))
              .load(
                  "http://kissota.ru:9000/skins/render/fullbody/${widget.data.profile?.username ?? "koliy82"}"))
          .buffer
          .asUint8List();
      Uint8List avatarBytes = (await NetworkAssetBundle(Uri.parse(
                  "http://kissota.ru:9000/skins/render/face/${widget.data.profile?.username ?? "koliy82"}"))
              .load(
                  "http://kissota.ru:9000/skins/render/face/${widget.data.profile?.username ?? "koliy82"}"))
          .buffer
          .asUint8List();
      Uint8List cloakBytes = (await NetworkAssetBundle(Uri.parse(
                  "http://kissota.ru:9000/cloaks/${widget.data.profile?.username ?? "koliy82"}"))
              .load(
                  "http://kissota.ru:9000/cloaks/${widget.data.profile?.username ?? "koliy82"}"))
          .buffer
          .asUint8List();

      firstUploadedSkin = Image.memory(firstSkinBytes);
      secondUploadedSkin = Image.memory(secondSkinBytes);
      avatar = Image.memory(avatarBytes);
      uploadedCloak = Image.memory(cloakBytes);
      setState(() {});
    } catch (e) {
      firstUploadedSkin = null;
      secondUploadedSkin = null;
      avatar = null;
    }
  }

  Future<void> uploadFile(String path) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
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
              content: Text('Максимальный размер файла 30MB'),
            ),
          );
        return;
      }
      var response = await dio.post(
        "http://kissota.ru:9000/$path/${widget.data.profile!.username}",
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            var message = switch (status) {
              200 => null,
              400 => 'Ошибка при обработке запроса',
              402 => 'Для загрузки плаща требуется подписка',
              404 => null,
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

      if (response.statusCode == 200 || response.statusCode == 404) {
        try {
          if (path == "skins") {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: CircularProgressIndicator()),
            );
            await Future.delayed(const Duration(seconds: 1));
            Uint8List firstSkinBytes = (await NetworkAssetBundle(Uri.parse(
                        "http://kissota.ru:9000/skins/render/fullbodyiso/${widget.data.profile?.username ?? "koliy82"}"))
                    .load(
                        "http://kissota.ru:9000/skins/render/fullbodyiso/${widget.data.profile?.username ?? "koliy82"}"))
                .buffer
                .asUint8List();
            Uint8List secondSkinBytes = (await NetworkAssetBundle(Uri.parse(
                        "http://kissota.ru:9000/skins/render/fullbody/${widget.data.profile?.username ?? "koliy82"}"))
                    .load(
                        "http://kissota.ru:9000/skins/render/fullbody/${widget.data.profile?.username ?? "koliy82"}"))
                .buffer
                .asUint8List();
            Uint8List avatarBytes = (await NetworkAssetBundle(Uri.parse(
                        "http://kissota.ru:9000/skins/render/face/${widget.data.profile?.username ?? "koliy82"}"))
                    .load(
                        "http://kissota.ru:9000/skins/render/face/${widget.data.profile?.username ?? "koliy82"}"))
                .buffer
                .asUint8List();

            firstUploadedSkin = Image.memory(firstSkinBytes);
            secondUploadedSkin = Image.memory(secondSkinBytes);
            avatar = Image.memory(avatarBytes);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Скин успешно обновлён")),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: CircularProgressIndicator()),
            );
            await Future.delayed(const Duration(seconds: 1));
            Uint8List cloakBytes = (await NetworkAssetBundle(Uri.parse(
                        "http://kissota.ru:9000/cloaks/${widget.data.profile?.username ?? "koliy82"}"))
                    .load(
                        "http://kissota.ru:9000/cloaks/${widget.data.profile?.username ?? "koliy82"}"))
                .buffer
                .asUint8List();
            uploadedCloak = Image.memory(cloakBytes);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Плащ успешно обновлён")),
            );
          }
        } catch (e) {
          firstUploadedSkin = null;
          secondUploadedSkin = null;
          avatar = null;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ошибка при обновлении")),
          );
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

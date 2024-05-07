import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_profile/src/core/utils/telegram_page.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';
import 'package:mine_profile/src/features/home/blocs/home/home_cubit.dart';
import 'package:mine_profile/src/features/home/widgets/change_password_form.dart';
import 'package:mine_profile/src/features/home/widgets/input_promo_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.data});
  final UserData data;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    context.read<HomeCubit>().setDrawerSliding(true);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  Widget build(BuildContext context) {
    var data = widget.data;
    return ListView(
      children: [
        ListTile(
          title: Text(data.profile?.username ?? "null"),
          subtitle: Text("@${data.user?.username ?? "telegram"}"),
          leading: GestureDetector(
            child: Image.network(
              "http://kissota.ru:9000/skins/render/face/${data.profile?.username ?? "koliy82"}.png",
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
            ),
            onTap: () => openTelegramPage(
              "https://t.me/${data.user?.username ?? "koliy822"}",
            ),
          ),
        ),
        InputPromoForm(data: widget.data),
        ChangePasswordForm(data: widget.data),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(top: 16, right: 32, left: 32),
          child: CupertinoButton.filled(
            onPressed: () {
              context.read<HomeCubit>().exit();
            },
            child: const Text(
              "Выйти",
              style: TextStyle(
                color: Colors.white,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Color.fromARGB(165, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

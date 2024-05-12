import 'package:flutter/material.dart';
import 'package:mine_profile/src/features/auth/models/minecraft_profile.dart';
import 'package:mine_profile/src/features/home/use_cases/date_format.dart';

class MinecraftStatisticCard extends StatelessWidget {
  const MinecraftStatisticCard(this.profile, {super.key});
  final MinecraftProfile profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      child: Card(
        child: ListTile(
          title: const Text("Minecraft"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text("uuid"),
              //     Text(profile.uuid?.toString() ?? "Нет информации"),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Никнейм"),
                  Text(profile.username?.toString() ?? "Нет информации"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Зарегистрирован"),
                  Text(dateFormat(profile.registerAt)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Подписка до"),
                  Text(
                    profile.subscribeEnd == null
                        ? "Нет подписки"
                        : dateFormat(profile.subscribeEnd),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Ещё дней действует"),
                  Text(
                    profile.subscribeEnd == null
                        ? "0"
                        : dateFormat(profile.subscribeEnd),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

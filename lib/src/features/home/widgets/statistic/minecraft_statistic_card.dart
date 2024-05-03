import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';

class MinecraftStatisticCard extends StatelessWidget {
  const MinecraftStatisticCard(this.profile, {super.key});
  final Profile profile;

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("uuid"),
                  Text(profile.uuid?.toString() ?? "Нет информации"),
                ],
              ),
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
                  Text(dateFormat(profile.subscribeEnd)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Действует ещё"),
                  Text(subDays(profile.subscribeEnd)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String dateFormat(String? date) {
    try {
      if (date == null) {
        return "Нет информации";
      }
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('kk:mm – dd.MM.yyyy').format(dateTime);
    } catch (e) {
      return date.toString();
    }
  }

  String subDays(String? date) {
    try {
      if (date == null) {
        return "Нет информации";
      }
      final now = DateTime.now();
      DateTime subDays = DateTime.parse(date);
      final difference = subDays.difference(now).inDays;
      if (difference <= 0) {
        return "нет подписки";
      }
      return "$difference дней";
    } catch (e) {
      return date.toString();
    }
  }
}

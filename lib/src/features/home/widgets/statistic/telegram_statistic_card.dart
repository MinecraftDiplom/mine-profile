import 'package:flutter/material.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';

class TelegramStatisticCard extends StatelessWidget {
  const TelegramStatisticCard(this.user, {super.key});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      child: Card(
        child: ListTile(
          title: const Text("Telegram"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("id"),
                  Text(user.id?.toString() ?? "Нет информации"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Имя пользователя"),
                  Text("@${user.username ?? "Не установлен"}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Имя"),
                  Text(user.firstName ?? "Не установлено"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Фамилия"),
                  Text(user.lastName ?? "Не установлена"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Количество браков"),
                  Text(user.braksCount.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mine_profile/src/features/auth/models/brak.dart';
import 'package:mine_profile/src/features/home/use_cases/date_format.dart';

class BrakStatisticCard extends StatelessWidget {
  const BrakStatisticCard(this.brak, {super.key});
  final Brak brak;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      child: Card(
        child: ListTile(
          title: const Text("Brak"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Первый партнёр"),
                  Text(brak.firstUser.username ?? "Нет информации"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Второй партнёр"),
                  Text(brak.secondUser.username ?? "Нет информации"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Ребёнок"),
                  Text(brak.baby?.username ?? "Нет"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Дней брака"),
                  Text(daysFromMillis(brak.time)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

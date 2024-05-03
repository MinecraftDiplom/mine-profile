import 'package:flutter/material.dart';
import 'package:mine_profile/src/features/home/widgets/statistic/server_status.dart';

class ServersInfo extends StatelessWidget {
  const ServersInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ServerStatus(25565, "Mini-Games"),
        ServerStatus(25563, "Tech"),
      ],
    );
  }
}

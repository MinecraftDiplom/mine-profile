import 'package:flutter/material.dart';
import 'package:mine_profile/src/features/home/models/server_data.dart';
import 'package:mine_profile/src/features/home/widgets/statistic/server_status.dart';

class ServersInfo extends StatelessWidget {
  const ServersInfo({super.key, this.gameServer, this.techServer});
  final ServerData? gameServer;
  final ServerData? techServer;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ServerStatus(data: gameServer),
          ServerStatus(
            data: techServer,
            maskColor: Colors.white.withAlpha(10),
            maskBlendMode: BlendMode.lighten,
          ),
        ],
      ),
    );
  }
}

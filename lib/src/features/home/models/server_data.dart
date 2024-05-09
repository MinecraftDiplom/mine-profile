import 'package:dart_minecraft/dart_minecraft.dart';
import 'package:flutter/cupertino.dart';

class ServerData {
  ServerData(this.port, this.name, this.asset);
  final int port;
  final String name;
  final String asset;

  Widget? server;

  Future<void> pingData() async {
    try {
      var data = await ping('kissota.ru', port: port);
      if (data == null) {
        server = offline();
      } else {
        server = Column(
          children: [
            Text("${data.response?.version.name}"),
            Text(
              "${data.response?.players.online.toString()}/${data.response?.players.max.toString()} игроков",
            ),
            const SizedBox(height: 8)
          ],
        );
      }
    } on PingException catch (_) {
      server = server = offline();
    }
  }

  Widget offline() {
    return const Column(
      children: [
        Text("server offline"),
        Text("0/0 игроков"),
        SizedBox(height: 8)
      ],
    );
  }
}

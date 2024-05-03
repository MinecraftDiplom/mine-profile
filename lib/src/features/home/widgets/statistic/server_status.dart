import 'package:dart_minecraft/dart_minecraft.dart';
import 'package:flutter/material.dart';

class ServerStatus extends StatelessWidget {
  const ServerStatus(this.port, this.name, {super.key});
  final int port;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 256,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset("assets/server_tech.png"),
            ),
          ),
          Text(name),
          FutureBuilder(
            future: ping('kissota.ru', port: port),
            builder: (context, snapshot) {
              var data = snapshot.data;
              if (data == null) {
                return const Column(
                  children: [
                    Text("server offline"),
                    Text("0/0 игроков"),
                    SizedBox(height: 8)
                  ],
                );
              } else {
                return Column(
                  children: [
                    Text("${data.response?.version.name}"),
                    Text(
                      "${data.response?.players.online.toString()}/${data.response?.players.max.toString()} игроков",
                    ),
                    const SizedBox(height: 8)
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

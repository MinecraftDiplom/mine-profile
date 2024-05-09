import 'package:flutter/material.dart';
import 'package:mine_profile/src/features/home/models/server_data.dart';

class ServerStatus extends StatelessWidget {
  const ServerStatus(
      {super.key, this.data, this.maskColor, this.maskBlendMode});
  final ServerData? data;
  final Color? maskColor;
  final BlendMode? maskBlendMode;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Card(
        child: SizedBox(
          height: 264,
          width: 174,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return Card(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: SizedBox(
              height: 264,
              width: 174,
              child: Image.asset(
                "assets/servers/${data!.asset}",
                fit: BoxFit.cover,
                color: maskColor,
                colorBlendMode: maskBlendMode,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(data!.name),
          data!.server ??
              const SizedBox(
                height: 48,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          // FutureBuilder(
          //   future: ping('kissota.ru', port: data.port),
          //   builder: (context, snapshot) {
          //     var data = snapshot.data;
          //     if (data == null) {
          //       return const Column(
          //         children: [
          //           Text("server offline"),
          //           Text("0/0 игроков"),
          //           SizedBox(height: 8)
          //         ],
          //       );
          //     } else {
          //       return Column(
          //         children: [
          //           Text("${data.response?.version.name}"),
          //           Text(
          //             "${data.response?.players.online.toString()}/${data.response?.players.max.toString()} игроков",
          //           ),
          //           const SizedBox(height: 8)
          //         ],
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}

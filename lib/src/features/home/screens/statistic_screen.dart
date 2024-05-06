import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mine_profile/src/features/auth/models/brak.dart';
import 'package:mine_profile/src/features/auth/models/minecraft_profile.dart';
import 'package:mine_profile/src/features/auth/models/user.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';
import 'package:mine_profile/src/features/home/blocs/home/home_cubit.dart';
import 'package:mine_profile/src/features/home/widgets/rive/rive_loading_widget.dart';
import 'package:mine_profile/src/features/home/widgets/statistic/brak_statistic_card.dart';
import 'package:mine_profile/src/features/home/widgets/statistic/minecraft_statistic_card.dart';
import 'package:mine_profile/src/features/home/widgets/statistic/servers_info.dart';
import 'package:mine_profile/src/features/home/widgets/statistic/telegram_statistic_card.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key, required this.data});
  final UserData data;

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  late EasyRefreshController _controller;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _controller = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: const ArcheryHeader(
        position: IndicatorPosition.locator,
        processedDuration: Duration(seconds: 1),
      ),
      onRefresh: () {
        // await Future.delayed(const Duration(seconds: 2));
        context.read<HomeCubit>().updateData();
        if (!mounted) {
          return;
        }
        setState(() {});
        _controller.finishRefresh();
        _controller.resetFooter();
      },
      controller: _controller,
      child: CustomScrollView(
        slivers: [
          const HeaderLocator.sliver(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const ServersInfo(),
                TelegramStatisticCard(
                  widget.data.user ?? User(),
                ),
                MinecraftStatisticCard(
                  widget.data.profile ?? MinecraftProfile(),
                ),
                BrakStatisticCard(
                  widget.data.brak ?? Brak(User(), User()),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

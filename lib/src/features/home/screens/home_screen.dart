import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mine_profile/src/core/utils/telegram_page.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';
import 'package:mine_profile/src/features/home/blocs/form_status.dart';
import 'package:mine_profile/src/features/home/blocs/home/home_cubit.dart';
import 'package:mine_profile/src/features/home/models/rive_icons.dart';
import 'package:mine_profile/src/features/home/screens/profile_screen.dart';
import 'package:mine_profile/src/features/home/screens/skin_screen.dart';
import 'package:mine_profile/src/features/home/screens/statistic_screen.dart';
import 'package:mine_profile/src/features/home/screens/tree_screen.dart';
import 'package:mine_profile/src/features/home/use_cases/home_use_case.dart';
import 'package:mine_profile/src/features/home/widgets/rive/rive_icon.dart';
import 'package:mine_profile/src/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        homeUseCase: HomeUseCase(),
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().updateData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.formStatus == FormStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Ошибка при обновлении данных'),
              ),
            );
        }
        if (state.formStatus == FormStatus.success) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Данные успешно обновлены'),
              ),
            );
        }
        if (state.formStatus == FormStatus.unAuth) {
          context.go(ScreenRoutes.welcome.path);
        }
      },
      builder: (context, state) {
        var data = state.userData ?? UserData();
        return Scaffold(
          appBar: AppBar(
            title: const Text("MineProfile"),
          ),
          drawer: Drawer(
            width: 280,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    data.profile?.username ?? "username",
                    style: const TextStyle(
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 1.0,
                          color: Color.fromARGB(165, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                  accountEmail: Text(
                    "@${data.user?.username ?? "telegram"}",
                    style: const TextStyle(
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 1.0,
                          color: Color.fromARGB(165, 0, 0, 0),
                        ),
                      ],
                    ),
                  ),
                  currentAccountPicture: GestureDetector(
                    child: Image.network(
                      "http://kissota.ru:9000/skins/render/head/${data.profile?.username}.png",
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return SizedBox(
                          width: 128,
                          height: 128,
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/default_avatar.png",
                      ),
                    ),
                    onTap: () => openTelegramPage(
                      "https://t.me/${data.user?.username ?? "koliy822"}",
                    ),
                  ),
                ),
                const ListTile(title: Text("Навигация")),
                ListTile(
                  title: const Text('Статистика'),
                  selected: _selectedIndex == 0,
                  onTap: () {
                    _onItemTapped(0);
                    Navigator.pop(context);
                  },
                  leading: const RiveIcon(RiveIcons.globe),
                  minLeadingWidth: 32,
                ),
                ListTile(
                  title: const Text('Скин'),
                  selected: _selectedIndex == 1,
                  onTap: () {
                    _onItemTapped(1);
                    Navigator.pop(context);
                  },
                  leading: const RiveIcon(RiveIcons.profile),
                  minLeadingWidth: 32,
                ),
                ListTile(
                  title: const Text('Профиль'),
                  selected: _selectedIndex == 2,
                  onTap: () {
                    _onItemTapped(2);
                    Navigator.pop(context);
                  },
                  leading: const RiveIcon(RiveIcons.gear),
                  minLeadingWidth: 32,
                ),
                ListTile(
                  title: const Text('Древо'),
                  selected: _selectedIndex == 3,
                  onTap: () {
                    _onItemTapped(3);
                    Navigator.pop(context);
                  },
                  leading: const RiveIcon(RiveIcons.network),
                  minLeadingWidth: 32,
                ),
                const Divider(),
                const ListTile(title: Text("Ссылки")),
                ListTile(
                  title: const Text('Подписка'),
                  selected: _selectedIndex == 4,
                  onTap: () => openTelegramPage("https://t.me/Koliy82Bot"),
                  leading: const RiveIcon(RiveIcons.wallet),
                  minLeadingWidth: 32,
                ),
                ListTile(
                  title: const Text('Новости'),
                  selected: _selectedIndex == 5,
                  onTap: () => openTelegramPage("https://t.me/kissotaru"),
                  leading: const RiveIcon(RiveIcons.notification),
                  minLeadingWidth: 32,
                ),
                ListTile(
                  title: const Text('Разработчик'),
                  selected: _selectedIndex == 6,
                  onTap: () => openTelegramPage("https://t.me/koliy822"),
                  leading: const RiveIcon(RiveIcons.mail),
                  minLeadingWidth: 32,
                ),
              ],
            ),
          ),
          drawerEdgeDragWidth:
              (MediaQuery.of(context).orientation == Orientation.portrait)
                  ? MediaQuery.of(context).size.width
                  : 0,
          body: switch (_selectedIndex) {
            0 => StatisticScreen(data: data),
            1 => SkinScreen(data: data),
            2 => ProfileScreen(data: data),
            3 => TreeViewScreen(data.user?.id ?? 760723365),
            _ => throw UnimplementedError(),
          },
        );
      },
    );
  }
}

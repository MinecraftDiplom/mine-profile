import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mine_profile/src/core/utils/telegram_page.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';
import 'package:mine_profile/src/features/home/blocs/form_status.dart';
import 'package:mine_profile/src/features/home/blocs/home/home_cubit.dart';
import 'package:mine_profile/src/features/home/screens/profile_screen.dart';
import 'package:mine_profile/src/features/home/screens/statistic_screen.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: Image.asset(
                      "assets/default_avatar.png",
                    ),
                    // child: Image.network(
                    //   "http://kissota.ru/profile/${data.user?.username}",
                    //   loadingBuilder: (context, child, loadingProgress) {
                    //     if (loadingProgress == null) return child;
                    //     return SizedBox(
                    //       height: 64,
                    //       width: 64,
                    //       child: CircularProgressIndicator(
                    //         color: Colors.black,
                    //         value: loadingProgress.expectedTotalBytes != null
                    //             ? loadingProgress.cumulativeBytesLoaded /
                    //                 loadingProgress.expectedTotalBytes!
                    //             : null,
                    //       ),
                    //     );
                    //   },
                    //   errorBuilder: (context, error, stackTrace) => Image.asset(
                    //     "assets/default_avatar.png",
                    //   ),
                    // ),
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
                  leading: const RiveIcon(RiveIcons.network),
                  minLeadingWidth: 32,
                ),
                ListTile(
                  title: const Text('Профиль'),
                  selected: _selectedIndex == 1,
                  onTap: () {
                    _onItemTapped(1);
                    Navigator.pop(context);
                  },
                  leading: const RiveIcon(RiveIcons.profile),
                  minLeadingWidth: 32,
                ),
                const Divider(),
                const ListTile(title: Text("Ссылки")),
                ListTile(
                  title: const Text('Подписка'),
                  selected: _selectedIndex == 3,
                  onTap: () => openTelegramPage("https://t.me/Koliy82Bot"),
                  leading: const RiveIcon(RiveIcons.wallet),
                  minLeadingWidth: 32,
                ),
                ListTile(
                  title: const Text('Новости'),
                  selected: _selectedIndex == 3,
                  onTap: () => openTelegramPage("https://t.me/kissotaru"),
                  leading: const RiveIcon(RiveIcons.notification),
                  // leading: const CircleAvatar(
                  //   radius: 15,
                  //   backgroundColor: Colors.blueAccent,
                  //   child: Icon(Icons.telegram_outlined, color: Colors.white),
                  // ),
                  minLeadingWidth: 32,
                ),
                ListTile(
                  title: const Text('Разработчик'),
                  selected: _selectedIndex == 3,
                  onTap: () => openTelegramPage("https://t.me/koliy822"),
                  leading: const RiveIcon(RiveIcons.mail),
                  // leading: const CircleAvatar(
                  //   radius: 15,
                  //   backgroundColor: Colors.blueAccent,
                  //   child: Icon(Icons.telegram_outlined, color: Colors.white),
                  // ),
                  minLeadingWidth: 32,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                  child: CupertinoButton.filled(
                    onPressed: () {
                      context.read<HomeCubit>().exit();
                    },
                    child: const Text(
                      "Выйти",
                      style: TextStyle(
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 2.0,
                            color: Color.fromARGB(165, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          drawerEdgeDragWidth: MediaQuery.of(context).size.width,
          body: switch (_selectedIndex) {
            0 => StatisticScreen(data: data),
            1 => ProfileScreen(data: data),
            // 2 => const Text("page3"),
            _ => throw UnimplementedError(),
          },
        );
      },
    );
  }
}

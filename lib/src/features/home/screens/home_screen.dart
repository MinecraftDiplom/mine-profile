import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mine_profile/src/core/extensions/context_extension.dart';
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
    final theme = context.theme;
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
          // ScaffoldMessenger.of(context)
          //   ..hideCurrentSnackBar()
          //   ..showSnackBar(
          //     const SnackBar(
          //       content: Text('Данные успешно обновлены'),
          //     ),
          //   );
        }
        if (state.formStatus == FormStatus.unAuth) {
          context.go(ScreenRoutes.welcome.path);
        }
      },
      builder: (context, state) {
        var data = state.userData ?? UserData();
        return Theme(
          data: theme.copyWith(
            textTheme: GoogleFonts.playTextTheme(theme.textTheme),
          ),
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "MineProfile",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
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
                        fontSize: 17,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.1, 1.1),
                            blurRadius: 1.1,
                            color: Color.fromARGB(128, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                    accountEmail: Text(
                      "@${data.user?.username ?? "telegram"}",
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.1, 1.1),
                            blurRadius: 1.1,
                            color: Color.fromARGB(128, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                    currentAccountPicture: GestureDetector(
                      child: Image.network(
                        "http://kissota.ru:9000/skins/render/head/${data.profile?.username}",
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
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          "assets/default_avatar.png",
                        ),
                      ),
                      onTap: () => openTelegramPage(
                        "https://t.me/${data.user?.username ?? "koliy822"}",
                      ),
                    ),
                  ),
                  const ListTile(
                      title: Text(
                    "Навигация",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  )),
                  ListTile(
                    title: const Text(
                      'Статистика',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                    selected: _selectedIndex == 0,
                    onTap: () {
                      _onItemTapped(0);
                      Navigator.pop(context);
                    },
                    leading: RiveIcon(
                      RiveIcons.globe,
                      isActive: _selectedIndex == 0,
                    ),
                    minLeadingWidth: 32,
                  ),
                  ListTile(
                    title: const Text(
                      'Скин',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                    selected: _selectedIndex == 1,
                    onTap: () {
                      _onItemTapped(1);
                      Navigator.pop(context);
                    },
                    leading: RiveIcon(
                      RiveIcons.profile,
                      isActive: _selectedIndex == 1,
                    ),
                    minLeadingWidth: 32,
                  ),
                  ListTile(
                    title: const Text(
                      'Профиль',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    selected: _selectedIndex == 2,
                    onTap: () {
                      _onItemTapped(2);
                      Navigator.pop(context);
                    },
                    leading: RiveIcon(
                      RiveIcons.gear,
                      isActive: _selectedIndex == 2,
                    ),
                    minLeadingWidth: 32,
                  ),
                  ListTile(
                    title: const Text(
                      'Древо',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    selected: _selectedIndex == 3,
                    onTap: () {
                      _onItemTapped(3);
                      Navigator.pop(context);
                    },
                    leading: RiveIcon(
                      RiveIcons.network,
                      isActive: _selectedIndex == 3,
                    ),
                    minLeadingWidth: 32,
                  ),
                  const Divider(),
                  const ListTile(
                      title: Text(
                    "Ссылки",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  )),
                  ListTile(
                    title: const Text(
                      'Подписка',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    selected: _selectedIndex == 4,
                    onTap: () => openTelegramPage("https://t.me/Koliy82Bot"),
                    leading: RiveIcon(
                      RiveIcons.wallet,
                      isActive: true,
                    ),
                    minLeadingWidth: 32,
                  ),
                  ListTile(
                    title: const Text(
                      'Новости',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    selected: _selectedIndex == 5,
                    onTap: () => openTelegramPage("https://t.me/kissotaru"),
                    leading: RiveIcon(
                      RiveIcons.notification,
                      isActive: true,
                    ),
                    minLeadingWidth: 32,
                  ),
                  ListTile(
                    title: const Text(
                      'Разработчик',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    selected: _selectedIndex == 6,
                    onTap: () => openTelegramPage("https://t.me/koliy822"),
                    leading: RiveIcon(
                      RiveIcons.mail,
                      isActive: true,
                    ),
                    minLeadingWidth: 32,
                  ),
                ],
              ),
            ),
            drawerEdgeDragWidth: (context.read<HomeCubit>().isDrawerSliding)
                ? MediaQuery.of(context).size.width
                : 0,
            // (MediaQuery.of(context).orientation == Orientation.portrait)
            //     ? MediaQuery.of(context).size.width
            //     : 0,
            body: switch (_selectedIndex) {
              0 => StatisticScreen(
                  data: data,
                  gameServer: state.games,
                  techServer: state.tech,
                ),
              1 => SkinScreen(data: data),
              2 => ProfileScreen(data: data),
              3 => TreeViewScreen(data.user?.id ?? 760723365),
              _ => throw UnimplementedError(),
            },
          ),
        );
      },
    );
  }
}

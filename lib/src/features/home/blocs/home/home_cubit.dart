import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mine_profile/src/features/auth/models/user_data_entity.dart';
import 'package:mine_profile/src/features/home/blocs/form_status.dart';
import 'package:mine_profile/src/features/home/models/server_data.dart';
import 'package:mine_profile/src/features/home/use_cases/home_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  ServerData games = ServerData(25565, "Mini-Games", "mini-games.png");
  ServerData tech = ServerData(25563, "Tech", "tech.webp");
  final HomeUseCase _homeUseCase;
  static const storage = FlutterSecureStorage();

  bool isDrawerSliding = true;

  HomeCubit({
    required HomeUseCase homeUseCase,
  })  : _homeUseCase = homeUseCase,
        super(const HomeState());

  void setDrawerSliding(bool mode) {
    emit(state.copyWith(formStatus: FormStatus.updating));
    isDrawerSliding = mode;
    emit(state.copyWith(formStatus: FormStatus.success));
  }

  Future<void> updateData() async {
    emit(state.copyWith(
        formStatus: FormStatus.initial, games: games, tech: tech));

    var data = await storage.read(key: "user_data");
    if (data == null) {
      emit(state.copyWith(formStatus: FormStatus.unAuth));
    }
    var localData = UserData.deserialize(data!);

    if (state.userData == null) {
      emit(state.copyWith(formStatus: FormStatus.updating));
    }

    try {
      var response = await _homeUseCase(localData.user!.username!);
      await storage.write(
        key: "user_data",
        value: UserData.serialize(response),
      );
      await games.pingData();
      await tech.pingData();
      emit(state.copyWith(
          formStatus: FormStatus.success,
          userData: response,
          games: games,
          tech: tech));
    } catch (err) {
      print(err.toString());
      emit(state.copyWith(formStatus: FormStatus.error));
    }
  }

  Future<void> exit() async {
    await storage.write(key: "auth", value: null);
    await storage.write(key: "user_data", value: null);
    emit(state.copyWith(formStatus: FormStatus.unAuth));
  }
}

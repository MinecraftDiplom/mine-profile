part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserData? userData;
  final FormStatus formStatus;
  final ServerData? games;
  final ServerData? tech;

  const HomeState({
    this.userData,
    this.games,
    this.tech,
    this.formStatus = FormStatus.initial,
  });

  HomeState copyWith({
    UserData? userData,
    FormStatus? formStatus,
    ServerData? games,
    ServerData? tech,
  }) {
    return HomeState(
      userData: userData ?? this.userData,
      formStatus: formStatus ?? this.formStatus,
      games: games ?? this.games,
      tech: tech ?? this.tech,
    );
  }

  @override
  List<Object?> get props => [
        userData,
        formStatus,
        games,
        tech,
      ];
}

part of 'home_cubit.dart';

class HomeState extends Equatable {
  final UserData? userData;
  final FormStatus formStatus;

  const HomeState({
    this.userData,
    this.formStatus = FormStatus.initial,
  });

  HomeState copyWith({
    UserData? userData,
    FormStatus? formStatus,
    RiveFile? riveFile,
  }) {
    return HomeState(
      userData: userData ?? this.userData,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [
        userData,
        formStatus,
      ];
}

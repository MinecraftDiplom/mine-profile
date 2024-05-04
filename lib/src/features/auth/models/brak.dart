import 'package:mine_profile/src/features/auth/models/user.dart';

class Brak {
  User firstUser = User();
  User secondUser = User();
  int? time;
  User? baby;

  Brak(this.firstUser, this.secondUser, {this.baby});

  Brak.fromJson(Map<String, dynamic> json) {
    firstUser = User.fromJson(json['firstUser']);
    secondUser = User.fromJson(json['secondUser']);
    baby = json['baby'] != null ? User.fromJson(json['baby']) : null;
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstUser'] = firstUser.toJson();
    data['secondUser'] = secondUser.toJson();
    if (baby != null) {
      data['baby'] = baby!.toJson();
    }
    if (time != null) {
      data['time'] = time;
    }
    return data;
  }
}

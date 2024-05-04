import 'dart:convert';

import 'package:mine_profile/src/features/auth/models/minecraft_profile.dart';
import 'package:mine_profile/src/features/auth/models/user.dart';

import 'brak.dart';

class UserData {
  User? user;
  MinecraftProfile? profile;
  Brak? brak;
  int? code;

  UserData({this.user, this.profile, this.code});

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    profile = json['profile'] != null
        ? MinecraftProfile.fromJson(json['profile'])
        : null;
    brak = json['brak'] != null ? Brak.fromJson(json['brak']) : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.brak != null) {
      data['profile'] = this.brak!.toJson();
    }
    data['code'] = this.code;
    return data;
  }

  static String serialize(UserData model) => json.encode(model.toJson());

  static UserData deserialize(String json) =>
      UserData.fromJson(jsonDecode(json));
}

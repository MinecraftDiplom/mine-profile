import 'dart:convert';

class UserData {
  User? user;
  Profile? profile;
  int? code;

  UserData({this.user, this.profile, this.code});

  UserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
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
    data['code'] = this.code;
    return data;
  }

  static String serialize(UserData model) => json.encode(model.toJson());

  static UserData deserialize(String json) =>
      UserData.fromJson(jsonDecode(json));
}

class User {
  int? id;
  bool? isBot;
  String? firstName;
  String? lastName;
  String? username;
  String? languageCode;
  int? braksCount;
  Id? iId;

  User(
      {this.id,
      this.isBot,
      this.firstName,
      this.lastName,
      this.username,
      this.languageCode,
      this.braksCount,
      this.iId});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isBot = json['isBot'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    languageCode = json['languageCode'];
    braksCount = json['braksCount'];
    iId = json['_id'] != null ? new Id.fromJson(json['_id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isBot'] = this.isBot;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['languageCode'] = this.languageCode;
    data['braksCount'] = this.braksCount;
    if (this.iId != null) {
      data['_id'] = this.iId!.toJson();
    }
    return data;
  }
}

class Id {
  int? timestamp;
  String? date;

  Id({this.timestamp, this.date});

  Id.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
    data['date'] = this.date;
    return data;
  }
}

class Profile {
  int? id;
  String? username;
  String? password;
  String? telegramId;
  String? registerAt;
  String? subscribeEnd;
  String? uuid;
  String? accessToken;
  String? serverID;

  Profile(
      {this.id,
      this.username,
      this.password,
      this.telegramId,
      this.registerAt,
      this.subscribeEnd,
      this.uuid,
      this.accessToken,
      this.serverID});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    telegramId = json['telegramId'];
    registerAt = json['registerAt'];
    subscribeEnd = json['subscribeEnd'];
    uuid = json['uuid'];
    accessToken = json['accessToken'];
    serverID = json['serverID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['telegramId'] = this.telegramId;
    data['registerAt'] = this.registerAt;
    data['subscribeEnd'] = this.subscribeEnd;
    data['uuid'] = this.uuid;
    data['accessToken'] = this.accessToken;
    data['serverID'] = this.serverID;
    return data;
  }

  Profile copyWith({
    int? id,
    String? username,
    String? password,
    String? telegramId,
    String? registerAt,
    String? subscribeEnd,
    String? uuid,
    String? accessToken,
    String? serverID,
  }) {
    return Profile(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      telegramId: telegramId ?? this.telegramId,
      registerAt: registerAt ?? this.registerAt,
      subscribeEnd: subscribeEnd ?? this.subscribeEnd,
      accessToken: accessToken ?? this.accessToken,
      serverID: serverID ?? this.serverID,
    );
  }
}

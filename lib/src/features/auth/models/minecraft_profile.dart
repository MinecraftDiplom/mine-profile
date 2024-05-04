class MinecraftProfile {
  int? id;
  String? username;
  String? password;
  String? telegramId;
  String? registerAt;
  String? subscribeEnd;
  String? uuid;
  String? accessToken;
  String? serverID;

  MinecraftProfile(
      {this.id,
      this.username,
      this.password,
      this.telegramId,
      this.registerAt,
      this.subscribeEnd,
      this.uuid,
      this.accessToken,
      this.serverID});

  MinecraftProfile.fromJson(Map<String, dynamic> json) {
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

  MinecraftProfile copyWith({
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
    return MinecraftProfile(
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

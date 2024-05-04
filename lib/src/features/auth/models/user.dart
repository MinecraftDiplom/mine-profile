import 'id.dart';

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

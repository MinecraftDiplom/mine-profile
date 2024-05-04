import 'package:mine_profile/src/features/auth/models/user.dart';

class FamilyTree {
  User? value;
  FamilyTree? left;
  FamilyTree? right;
  FamilyTree(this.value);

  FamilyTree.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? User.fromJson(json['value']) : null;
    left = json['left'] != null ? FamilyTree.fromJson(json['left']) : null;
    right = json['right'] != null ? FamilyTree.fromJson(json['right']) : null;
  }
}

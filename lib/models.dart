import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

@JsonSerializable()
class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phone;

  UserModel({this.uid,this.email, this.name, this.phone});

  // receiving data from server
  factory UserModel.fromJson(Map<String, Object?> json) => _$UserFromJson(json);
  Map<String, Object?> toJson() => _$UserToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

@JsonSerializable()
class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phone;

  UserModel({this.uid, this.email, this.name, this.phone});

  // receiving data from server
  UserModel.fromJson(json)
      : this(
          uid: json['uid']! as String,
          email: json['email']! as String,
          name: json['name']! as String,
          phone: json['phone']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
    };
  }
}

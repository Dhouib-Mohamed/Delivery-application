import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';

@JsonSerializable()
class UserModel {
  String? email;
  String? name;
  String? phone;

  UserModel({ this.email, this.name, this.phone});

  // receiving data from server
  UserModel.fromJson(json)
      : this(
          email: json['email']! as String,
          name: json['name']! as String,
          phone: json['phone']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
    };
  }
}

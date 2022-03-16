import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:geocoding/geocoding.dart';

@JsonSerializable()
class UserModel {
  String email;
  String name;
  String? phone;
  bool? autoSigned = false;
  UserModel(
      {required this.email, required this.name, this.phone, this.autoSigned});

  // receiving data from server
  UserModel.fromJson(json)
      : this(
          email: json['email']! as String,
          name: json['name']! as String,
          phone: json['phone']! as String,
          autoSigned: json['autoSigned']! as bool,
        );
  Map<String, Object?> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'autoSigned': autoSigned,
    };
  }
}

@JsonSerializable()
class RestaurantModel {
  String name;
  String photoUrl;
  GeoPoint location;
  Future<String>? description;
  String? id;

  RestaurantModel(
      {required this.name, required this.photoUrl, required this.location});
  Future<String> getLocation() async {
    late String d;
    await placemarkFromCoordinates(location.latitude, location.longitude)
        .then((value) {
      d =
          "${value[0].subAdministrativeArea} ${value.first.administrativeArea} ${value.first.country}";
    });
    return d;
  }

  // receiving data from server
  RestaurantModel.fromJson(json)
      : this(
          name: json["name"]! as String,
          photoUrl: json["photoUrl"]! as String,
          location: json["location"]! as GeoPoint,
        );
  Map<String, Object?> toJson() {
    return {
      'location': location,
      'name': name,
      'photoUrl': photoUrl,
    };
  }
}

@JsonSerializable()
class AddressModel {
  GeoPoint location;
  Future<String>? description;

  AddressModel({required this.location});
  Future<String> getLocation() async {
    late String d;
    await placemarkFromCoordinates(location.latitude, location.longitude)
        .then((value) {
      d =
      "${value[0].subAdministrativeArea} ${value.first.administrativeArea} ${value.first.country}";
    });
    return d;
  }

  // receiving data from server
  AddressModel.fromJson(json)
      : this(
          location: json['location'] as GeoPoint,
        );
  Map<String, Object?> toJson() {
    return {
      'location': location,
    };
  }
}

@JsonSerializable()
class DealModel {
  String name;
  String photoUrl;
  num price;
  String description;

  DealModel(
      {required this.name,
      required this.photoUrl,
      required this.description,
      required this.price});

  // receiving data from server
  DealModel.fromJson(json)
      : this(
          name: json['name']! as String,
          photoUrl: json['photoUrl']! as String,
          price: json['price']! as num,
          description: json['description']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'price': price,
      'name': name,
      'photoUrl': photoUrl,
      'description': description,
    };
  }
}
@JsonSerializable()
class CategoryModel {
  String name;

  CategoryModel(
      {required this.name});

  // receiving data from server
  CategoryModel.fromJson(json)
      : this(
          name: json['name']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'name': name,
    };
  }
}

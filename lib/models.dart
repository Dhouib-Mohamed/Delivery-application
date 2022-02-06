import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserModel {
  String? email;
  String? name;
  String? phone;

  UserModel({this.email, this.name, this.phone});

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

@JsonSerializable()
class RestaurantModel {
  String? name;
  String? photoUrl;
  String? location;

  RestaurantModel({this.name, this.photoUrl, this.location});

  // receiving data from server
  RestaurantModel.fromJson(json)
      : this(
          name: json['name']! as String,
          photoUrl: json['photoUrl']! as String,
          location: json['location']! as String,
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
class AdressModel {
  String? name;
  String? location;

  AdressModel({this.name, this.location});

  // receiving data from server
  AdressModel.fromJson(json)
      : this(
          name: json['name']! as String,
          location: json['location']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'location': location,
      'name': name,
    };
  }
}

@JsonSerializable()
class TypeModel {
  String? name;
  String? photoUrl;

  TypeModel({this.name, this.photoUrl});

  // receiving data from server
  TypeModel.fromJson(json)
      : this(
          name: json['name']! as String,
          photoUrl: json['photoUrl']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'name': name,
      'photoUrl': photoUrl,
    };
  }
}

@JsonSerializable()
class DealModel {
  String? name;
  String? photoUrl;
  String? price;
  String? description;

  DealModel({this.name, this.photoUrl, this.description, this.price});

  // receiving data from server
  DealModel.fromJson(json)
      : this(
          name: json['name']! as String,
          photoUrl: json['photoUrl']! as String,
          price: json['price']! as String,
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

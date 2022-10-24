// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.image,
    this.password,
    this.isAvailable,
    this.sessionToken,
    this.notificationToken
  });

  String? id;
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? image;
  String? password;
  String? isAvailable;
  String? sessionToken;
  String? notificationToken;


  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    lastname: json["lastname"],
    phone: json["phone"],
    image: json["image"],
    password: json["password"],
    isAvailable: json["isAvailable"],
    sessionToken: json["session_token"],
    notificationToken: json["notification_token"],
  );

  static List<User> fromJsonList(List<dynamic> jsonList){
    List<User> toList = [];

    jsonList.forEach((item) {
       User user = User.fromJson(item);
       toList.add(user);
    });

    return toList;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "image": image,
    "password": password,
    "isAvailable": isAvailable,
    "session_token": sessionToken,
    "notification_token": notificationToken,
  };
}

// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String photoUrl;
  String email;
  String name;
  String fcmToken;
  bool isAllowRequest;

  UserModel({
    required this.id,
    required this.photoUrl,
    required this.email,
    required this.name,
    required this.fcmToken,
    required this.isAllowRequest,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        photoUrl: json["photo_url"],
        email: json["email"],
        name: json["name"],
        isAllowRequest: json["is_allow_request"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo_url": photoUrl,
        "email": email,
        "name": name,
        "is_allow_request": isAllowRequest,
        "fcm_token": fcmToken,
      };
}

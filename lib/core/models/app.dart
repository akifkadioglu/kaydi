// To parse this JSON data, do
//
//     final appModel = appModelFromJson(jsonString);

import 'dart:convert';

AppModel appModelFromJson(String str) => AppModel.fromJson(json.decode(str));

String appModelToJson(AppModel data) => json.encode(data.toJson());

class AppModel {
  String id;
  String token;
  String name;
  String email;
  String language;

  AppModel({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    required this.language,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) => AppModel(
        id: json["id"],
        token: json["token"],
        name: json["name"],
        email: json["email"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "name": name,
        "email": email,
        "language": language,
      };
}

// To parse this JSON data, do
//
//     final userListsModel = userListsModelFromJson(jsonString);

import 'dart:convert';

UserListsModel userListsModelFromJson(String str) => UserListsModel.fromJson(json.decode(str));

String userListsModelToJson(UserListsModel data) => json.encode(data.toJson());

class UserListsModel {
    String userId;
    String listId;

    UserListsModel({
        required this.userId,
        required this.listId,
    });

    factory UserListsModel.fromJson(Map<String, dynamic> json) => UserListsModel(
        userId: json["user_id"],
        listId: json["list_id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "list_id": listId,
    };
}

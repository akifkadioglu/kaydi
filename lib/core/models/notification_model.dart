// To parse this JSON data, do
//
//     final fNotificationModel = fNotificationModelFromJson(jsonString);

import 'dart:convert';

FNotificationModel fNotificationModelFromJson(String str) => FNotificationModel.fromJson(json.decode(str));

String fNotificationModelToJson(FNotificationModel data) => json.encode(data.toJson());

class FNotificationModel {
    List<String> registrationIds;
    Notification notification;

    FNotificationModel({
        required this.registrationIds,
        required this.notification,
    });

    factory FNotificationModel.fromJson(Map<String, dynamic> json) => FNotificationModel(
        registrationIds: List<String>.from(json["registration_ids"].map((x) => x)),
        notification: Notification.fromJson(json["notification"]),
    );

    Map<String, dynamic> toJson() => {
        "registration_ids": List<dynamic>.from(registrationIds.map((x) => x)),
        "notification": notification.toJson(),
    };
}

class Notification {
    String body;
    String title;

    Notification({
        required this.body,
        required this.title,
    });

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        body: json["body"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "body": body,
        "title": title,
    };
}

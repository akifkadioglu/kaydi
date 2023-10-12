// To parse this JSON data, do
//
//     final listTaskModel = listTaskModelFromJson(jsonString);

import 'dart:convert';

ListTaskModel listTaskModelFromJson(String str) => ListTaskModel.fromJson(json.decode(str));

String listTaskModelToJson(ListTaskModel data) => json.encode(data.toJson());

class ListTaskModel {
  List<ListElement> list;

  ListTaskModel({
    required this.list,
  });

  factory ListTaskModel.fromJson(Map<String, dynamic> json) => ListTaskModel(
        list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
      };
}

class ListElement {
  String id;
  String name;
  List<Task> task;
  bool inCloud;

  ListElement({
    required this.id,
    required this.name,
    required this.task,
    required this.inCloud,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        name: json["name"],
        task: List<Task>.from(json["task"].map((x) => Task.fromJson(x))),
        inCloud: json["in_cloud"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "task": List<dynamic>.from(task.map((x) => x.toJson())),
        "in_cloud": inCloud,
      };
}

class Task {
  String id;
  String task;
  bool isChecked;

  Task({
    required this.id,
    required this.task,
    required this.isChecked,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        task: json["task"],
        isChecked: json["is_checked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "is_checked": isChecked,
      };
}

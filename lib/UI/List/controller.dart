import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';

void getTasks() async {
  ListsController c = Get.put(ListsController());
  c.task.value = c.list.firstWhere((element) => element.id == c.theList.value.id).task;

  c.theListUserIds.value = [""];
  var usersOfList =
      await CloudManager.getCollection(CloudManager.USER_LISTS).where('list_id', isEqualTo: c.theList.value.id).get();

  for (var element in usersOfList.docs) {
    c.theListUserIds.add(element['user_id']);
  }
}

void checkTask(ListElement theList, Task task) async {
  ListsController c = Get.put(ListsController());
  c.task.firstWhere((element) => element.id == task.id).isChecked =
      !c.task.firstWhere((element) => element.id == task.id).isChecked;
  c.task.refresh();
  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);
  if (theList.inCloud) {
    var docRef = CloudManager.getDoc(CloudManager.LISTS, theList.id);
    var documentSnapshot = await docRef.get();

    if (documentSnapshot.exists) {
      List<dynamic> currentArray = documentSnapshot.data()?["task"] ?? [];

      int itemIndex = currentArray.indexWhere((item) {
        return item is Map<String, dynamic> && item["id"] == task.id;
      });

      if (itemIndex != -1) {
        currentArray[itemIndex]["is_checked"] = !currentArray[itemIndex]["is_checked"];
        docRef.update({"task": currentArray});
      }
    }
  } else {
    model.list
            .firstWhere((element) => element.id == theList.id)
            .task
            .firstWhere((element) => element.id == task.id)
            .isChecked =
        !model.list
            .firstWhere((element) => element.id == theList.id)
            .task
            .firstWhere((element) => element.id == task.id)
            .isChecked;

    StorageManager.instance.setData(SKey.LISTS, json.encode(model));
  }
}

void deleteTask(ListElement theList, Task task) {
  ListsController c = Get.put(ListsController());
  if (theList.inCloud) {
    var docRef = CloudManager.getDoc(CloudManager.LISTS, theList.id);

    docRef.update({
      "task": FieldValue.arrayRemove([task.toJson()])
    });
  } else {
    var list = StorageManager.instance.getData(SKey.LISTS);
    var model = listTaskModelFromJson(list);

    model.list.firstWhere((element) => element.id == theList.id).task.removeWhere((element) => element.id == task.id);

    StorageManager.instance.setData(SKey.LISTS, json.encode(model));
  }
  c.task.removeWhere((element) => element.id == task.id);
}

Future<dynamic> deleteTaskDialog(BuildContext context, double width, Task task, ListElement list) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        elevation: 0,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(translate(IKey.DELETE_TASK)),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(translate(IKey.CLOSE)),
                ),
              ),
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 23, 116, 153),
                    elevation: 0,
                  ),
                  onPressed: () {
                    deleteTask(list, task);
                    RouteManager.back();
                  },
                  child: Text(translate(IKey.DELETE)),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<dynamic> showTaskDialog(BuildContext context, double width, Task task, ListElement theList) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        scrollable: true,
        elevation: 0,
        content: Text(task.task),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(translate(IKey.CLOSE)),
                ),
              ),
              SizedBox(
                width: width,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 23, 116, 153),
                    elevation: 0,
                  ),
                  onPressed: () {
                    checkTask(theList, task);
                    RouteManager.back();
                  },
                  child: Text(task.isChecked ? translate(IKey.UNCHECK) : translate(IKey.CHECK)),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

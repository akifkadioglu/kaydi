import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/routes/manager.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';

void getTasks(String id) {
  ListsController c = Get.put(ListsController());
  c.task.value = c.list.firstWhere((element) => element.id == id).task;
}

void checkTask(String list_id, String task_id) {
  ListsController c = Get.put(ListsController());

  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);

  model.list
          .firstWhere((element) => element.id == list_id)
          .task
          .firstWhere((element) => element.id == task_id)
          .isChecked =
      !model.list
          .firstWhere((element) => element.id == list_id)
          .task
          .firstWhere((element) => element.id == task_id)
          .isChecked;

  StorageManager.instance.setData(SKey.LISTS, json.encode(model));

  c.task.firstWhere((element) => element.id == task_id).isChecked =
      !c.task.firstWhere((element) => element.id == task_id).isChecked;
  c.task.refresh();
}

void deleteTask(String list_id, String task_id) {
  ListsController c = Get.put(ListsController());

  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);

  model.list.firstWhere((element) => element.id == list_id).task.removeWhere((element) => element.id == task_id);

  StorageManager.instance.setData(SKey.LISTS, json.encode(model));

  c.task.removeWhere((element) => element.id == task_id);
}

Future<dynamic> deleteTaskDialog(BuildContext context, double width, String task_id, String list_id) {
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
                    deleteTask(list_id, task_id);
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

Future<dynamic> showTaskDialog(BuildContext context, double width, Task task, String list_id) {
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
                    checkTask(list_id, task.id);
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

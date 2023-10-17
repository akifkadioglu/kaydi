import 'dart:convert';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';
import 'package:uuid/uuid.dart';

void createTask(String task, ListElement theList) async {
  ListsController c = Get.put(ListsController());

  var uuid = Uuid();

  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);

  var newTask = Task(id: uuid.v1(), task: task.trim(), isChecked: false);
  c.task.add(newTask);
  model.list.firstWhereOrNull((element) => element.id == theList.id)?.task.add(newTask);
  StorageManager.instance.setData(SKey.LISTS, json.encode(model));
  print(theList.inCloud);
  if (theList.inCloud) {
    var docRef = CloudManager.getDoc(CloudManager.LISTS, theList.id);
    await docRef.update({
      "task": FieldValue.arrayUnion([newTask.toJson()]),
    });
  }
}

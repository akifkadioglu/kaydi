import 'dart:convert';

import 'package:get/get.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';
import 'package:uuid/uuid.dart';

void createList(String name) {
  ListsController c = Get.put(ListsController());
  var uuid = Uuid();

  var list = StorageManager.instance.getData(SKey.LISTS);
  var model = listTaskModelFromJson(list);
  var newElement = ListElement(id: uuid.v1(), name: name.trim(), task: [], inCloud: false);
  model.list.add(
    newElement,
  );
  model.list.sort(
    (a, b) => a.name.compareTo(b.name),
  );
  StorageManager.instance.setData(SKey.LISTS, json.encode(model));
  c.list.add(newElement);
  c.list.sort(
    (a, b) => a.name.compareTo(b.name),
  );
}

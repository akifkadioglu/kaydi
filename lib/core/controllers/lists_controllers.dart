import 'dart:convert';

import 'package:get/get.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';

class ListsController extends GetxController {
  var list = <ListElement>[].obs;
  var task = <Task>[].obs;

  var taskName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getLists();
  }

  void setTaskName(String v) => taskName.value = v;

  void getLists() {
    print(json.encode(json.decode(StorageManager.instance.getData(SKey.LISTS))));
    list.value = listTaskModelFromJson(StorageManager.instance.getData(SKey.LISTS)).list;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
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
    list.value = listTaskModelFromJson(StorageManager.instance.getData(SKey.LISTS)).list;
    if (FirebaseAuth.instance.currentUser == null) {
      list.value = list.where((element) => !element.inCloud).toList();
    }
  }
}

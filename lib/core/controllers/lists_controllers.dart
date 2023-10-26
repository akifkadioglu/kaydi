import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/language/initialize.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/notifications/manager.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';
import 'package:kaydi_mobile/core/models/notification_model.dart' as fbm;

class ListsController extends GetxController {
  var listIds = <String>[].obs;
  var list = <ListElement>[].obs;
  var task = <Task>[].obs;
  var theList = ListElement(id: "", name: "", task: [], inCloud: false).obs;
  var theListUserIds = <String>[""].obs;

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

  Future<void> sendNotificationToListUsers(IKey body, {String? info = ""}) async {
    var users = await CloudManager.getCollection(CloudManager.USERS).where('id', whereIn: theListUserIds).get();
    List<String> tokens = users.docs.map((e) => e['fcm_token'].toString()).toList();
    NotificationManager().SendNotification(
      tokens,
      fbm.Notification(body: body.name, title: theList.value.name + (info! != "" ? " - " + info : "")),
    );
  }

  bool areListsEqual(List<dynamic> list1, List<dynamic> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    for (var i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }

    return true;
  }
}

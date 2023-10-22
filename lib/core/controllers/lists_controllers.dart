import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/models/list_task.dart';
import 'package:kaydi_mobile/core/notifications/manager.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';
import 'package:kaydi_mobile/core/models/notification_model.dart' as fbm;

class ListsController extends GetxController {
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

  Future<void> sendNotificationToListUsers(String body) async {
    print(theListUserIds);
    var users = await CloudManager.getCollection(CloudManager.USERS).where('id', whereIn: theListUserIds).get();
    List<String> tokens = users.docs.map((e) => e['fcm_token'].toString()).toList();
    NotificationManager().SendNotification(tokens, fbm.Notification(body: body, title: theList.value.name));
  }
}

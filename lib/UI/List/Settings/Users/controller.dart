import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/List/Settings/Users/view_controller.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/controllers/lists_controllers.dart';
import 'package:kaydi_mobile/core/models/user_model.dart';

void getListUsers() async {
  ListsController c = Get.put(ListsController());
  ListUsersViewController listUsersViewController = Get.put(ListUsersViewController());
  listUsersViewController.setLoading;
  c.theListUserIds.value = [""];
  var usersOfList =
      await CloudManager.getCollection(CloudManager.USER_LISTS).where('list_id', isEqualTo: c.theList.value.id).get();

  for (var element in usersOfList.docs) {
    c.theListUserIds.add(element['user_id']);
  }
  var userList = await CloudManager.getCollection(CloudManager.USERS).where('id', whereIn: c.theListUserIds).get();
  listUsersViewController.users.value = userList.docs
      .map(
        (e) => UserModel(
          id: e["id"],
          photoUrl: e["photo_url"],
          email: e["email"],
          name: e["name"],
          fcmToken: e["fcm_token"],
          isAllowRequest: e["is_allow_request"],
        ),
      )
      .toList();
  listUsersViewController.setLoading;
}

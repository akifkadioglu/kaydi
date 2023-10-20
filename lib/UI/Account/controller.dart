import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Account/view_controller.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';
import 'package:kaydi_mobile/core/models/user_model.dart';

void isAllowRequest(String id) async {
  AccountViewController c = Get.put(AccountViewController());
  c.setLoading;
  var user = await CloudManager.getDoc(CloudManager.USERS, id).get();
  c.setLoading;
  c.isAllow.value = user["is_allow_request"];
}

void switchAllow() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AccountViewController c = Get.put(AccountViewController());
  CloudManager.getDoc(CloudManager.USERS, auth.currentUser?.uid ?? "").update(
    UserModel(
      id: auth.currentUser?.uid ?? "",
      photoUrl: auth.currentUser?.photoURL ?? "",
      email: auth.currentUser?.email ?? "",
      name: auth.currentUser?.displayName ?? "",
      isAllowRequest: !c.isAllow.value,
    ).toJson(),
  );
  c.isAllow.value = !c.isAllow.value;
}

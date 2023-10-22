import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:kaydi_mobile/UI/Account/view_controller.dart';
import 'package:kaydi_mobile/core/cloud/manager.dart';

void isAllowRequest(String id) async {
  AccountViewController c = Get.put(AccountViewController());
  c.setLoading;
  var user = await CloudManager.getDoc(CloudManager.USERS, id).get();
  c.setLoading;
  c.isAllow.value = user["is_allow_request"];
}

void switchAllow() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AccountViewController c = Get.put(AccountViewController());

  var docRef = CloudManager.getDoc(CloudManager.USERS, auth.currentUser?.uid ?? "");
  var docSnapshot = await docRef.get();
  if (docSnapshot.exists) {
    var user = docSnapshot.data();
    user?["is_allow_request"] = !user["is_allow_request"];
    docRef.update(user!);
  }
  c.isAllow.value = !c.isAllow.value;
}

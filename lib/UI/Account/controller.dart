import 'package:kaydi_mobile/core/cloud/manager.dart';

void isAllowRequest(String id) async {
  var user = CloudManager.getDoc(CloudManager.USERS, id);
  print(await user.get().toString());
}

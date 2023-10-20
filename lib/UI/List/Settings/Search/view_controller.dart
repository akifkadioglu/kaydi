import 'package:get/get.dart';
import 'package:kaydi_mobile/core/models/user_model.dart';

class TodoListSearchViewController extends GetxController {
  var isLoading = false.obs;
  var mail = ''.obs;
  var users = <UserModel>[].obs;

  get setLoading => isLoading.value = !isLoading.value;
  void setMail(String v) => mail.value = v;
}

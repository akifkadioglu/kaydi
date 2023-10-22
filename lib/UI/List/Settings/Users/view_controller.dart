import 'package:get/get.dart';
import 'package:kaydi_mobile/core/models/user_model.dart';

class ListUsersViewController extends GetxController {
  var users = <UserModel>[].obs;
  var isLoading = false.obs;

  get setLoading => isLoading.value = !isLoading.value;
}

import 'package:get/get.dart';

class TodoListSettingsViewController extends GetxController {
  var isLoading = false.obs;
  var notification = false.obs;

  get setLoading => isLoading.value = !isLoading.value;
}

import 'package:get/get.dart';

class AccountViewController extends GetxController {
  var isLoading = false.obs;
  var isAllow = false.obs;
  get setLoading => isLoading.value = !isLoading.value;
}

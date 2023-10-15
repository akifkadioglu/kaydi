import 'package:get/get.dart';

class LoginViewController extends GetxController {
  var startAnimation = false.obs;
  var isLoading = false.obs;

  get setStartAnimation => startAnimation.value = !startAnimation.value;
  get setLoading => isLoading.value = !isLoading.value;
}

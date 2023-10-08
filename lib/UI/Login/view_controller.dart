import 'package:get/get.dart';

class LoginViewController extends GetxController {
  var startAnimation = false.obs;

  get setStartAnimation => startAnimation.value = !startAnimation.value;
}

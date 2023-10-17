import 'package:get/get.dart';

class HomeViewController extends GetxController {
  var isLoading = false.obs;

  get setLoading => isLoading.value = !isLoading.value;
}

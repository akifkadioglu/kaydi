import 'package:get/get.dart';

class CreateListViewController extends GetxController {
  var counter = ''.obs;

  void setCounter(String v) => counter.value = v;
}

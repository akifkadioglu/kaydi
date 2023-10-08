import 'package:get/get.dart';

class CreateTaskViewController extends GetxController {
  var counter = ''.obs;

  void setCounter(String v) => counter.value = v;
}

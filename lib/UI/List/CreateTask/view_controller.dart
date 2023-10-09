import 'package:get/get.dart';

class CreateTaskViewController extends GetxController {
  var taskName = ''.obs;

  void setTaskName(String v) => taskName.value = v;
}

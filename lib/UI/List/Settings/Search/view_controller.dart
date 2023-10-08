import 'package:get/get.dart';

class TodoListSearchViewController extends GetxController {
  var mail = ''.obs;

  void setMail(String v) => mail.value = v;
}

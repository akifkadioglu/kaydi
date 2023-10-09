import 'package:get/get.dart';

class CreateListViewController extends GetxController {
  var listName = ''.obs;

  void setListName(String v) => listName.value = v;
}

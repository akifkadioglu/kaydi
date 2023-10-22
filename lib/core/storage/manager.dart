import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class StorageManager {
  static final StorageManager _instance = StorageManager._init();

  GetStorage? box;
  static StorageManager get instance => _instance;

  StorageManager._init() {
    box = GetStorage();
  }
  void setData(SKey key, dynamic value) => GetStorage().write(key.name, value);
  void setList(SKey storageKey, List<dynamic> storageValue) async =>
      await GetStorage().write(storageKey.name, jsonEncode(storageValue));

  int? getInt(SKey key) => GetStorage().read(key.name);

  String? getString(SKey key) => GetStorage().read(key.name);

  bool? getBool(SKey key) => GetStorage().read(key.name);

  double? getDouble(SKey key) => GetStorage().read(key.name);

  dynamic getData(SKey key) => GetStorage().read(key.name);

  List<dynamic> getList(SKey storageKey) {
    List<dynamic> result = jsonDecode(GetStorage().read(storageKey.name) ?? "[]");
    return result;
  }

  void clearData() async => GetStorage().erase();
}

enum SKey {
  APP,
  LISTS,
  NOTIFICATIONS,
  FCM_TOKEN,
}

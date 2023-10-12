import 'dart:convert';

import 'package:get/get.dart';
import 'package:kaydi_mobile/core/language/en.dart';
import 'package:flutter/material.dart';
import 'package:kaydi_mobile/core/language/tr.dart';
import 'package:kaydi_mobile/core/models/app.dart';
import 'package:kaydi_mobile/core/storage/manager.dart';

String translate(IKey? key) {
  return key == null ? '' : key.name.tr;
}

void ChangeLanguage(Locale locale) {
  // StorageManager.instance.setData(SKey.APP, )

  var app = StorageManager.instance.getData(SKey.APP);
  var model = appModelFromJson(app);
  model.language = locale.toString();

  StorageManager.instance.setData(SKey.APP, json.encode(model));

  Get.updateLocale(locale);
}

class Languages {
  static const TURKISH = Locale('tr', 'TR');
  static const ENGLISH = Locale('en', 'US');
}

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': English,
        'tr_TR': Turkish,
      };
}

enum IKey {
  WELCOME_TO_KAYDI,
  TURKISH,
  ENGLISH,
  CONTINUE_WITH_GOOGLE,
  CONTINUE_OFFLINE,
  NEW_LIST,
  TITLE_OF_LIST,
  TITLE_OF_LIST_DESCRIPTION,
  CANCEL,
  CREATE,
  PROFILE,
  EMAIL,
  NAME,
  LIST_REQUESTS,
  LOGOUT,
  NEW_TASK,
  NEW_TASK_DESCRIPTION,
  ADD_SOMEONE,
  ADD_SOMEONE_DESCRIPTION,
  NOTIFICATIONS,
  MOVE_TO_CLOUD,
  MOVE_TO_CLOUD_DESCRIPTION,
  MOVE_TO_CLOUD_DESCRIPTION_2,
  LEAVE,
  LEAVE_DESCRIPTION,
  SEARCH_EMAIL,
  DELETE_TASK,
  CLOSE,
  DELETE,
  CHECK,
  UNCHECK,
}

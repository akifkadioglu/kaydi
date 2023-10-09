import 'package:get/get.dart';
import 'package:kaydi_mobile/core/language/en.dart';
import 'package:flutter/material.dart';
import 'package:kaydi_mobile/core/language/tr.dart';

String translate(IKey? key) {
  return key == null ? '' : key.name.tr;
}

void ChangeLanguage(Locale locale) {
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
}

import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:money_manager/sharepreference/sharepre.dart';

class AppTranslations {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  AppTranslations(Locale locale) {
    this.locale = locale;
    _localisedValues = null;
  }

  static AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

  static Future<AppTranslations> load(Locale locale) async {
    String en = await PreUtil.getData(PreUtil.langauge);
    if (en == null) {
      en = "en";
    }
    AppTranslations appTranslations = AppTranslations(locale);
//    String jsonContent =await rootBundle.loadString("resource/langs/${locale.languageCode}.json");
    String jsonContent =
        await rootBundle.loadString("resource/langs/$en.json");
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  get currentLanguage => locale.languageCode;

  String trans(String key) {
    if (_localisedValues != null) {
      return _localisedValues[key] ?? "$key not found";
    } else {
      return "Translating..";
    }
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Languages.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale(DEFAULT_LANGUAGE_CODE);

  Locale get appLocal => _appLocale ?? Locale(DEFAULT_LANGUAGE_CODE);

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(LANGUAGE_CODE) == null) {
      _appLocale = Locale(DEFAULT_LANGUAGE_CODE);

      return null;
    }

    _appLocale = Locale(prefs.getString(LANGUAGE_CODE));

    return null;
  }

  void changeLanguage(Locale newLocale) async {
    if (_appLocale == newLocale) {
      return;
    }

    _appLocale = Locale(newLocale.languageCode, newLocale.countryCode ?? "");

    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(LANGUAGE_CODE, newLocale.languageCode);
    await prefs.setString(COUNTRY_CODE, newLocale.countryCode ?? "");

    notifyListeners();
  }
}

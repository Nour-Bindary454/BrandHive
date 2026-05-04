import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsViewModel extends ChangeNotifier {
  bool _pushNotifications = true;
  bool _emailPromotions = false;
  bool _orderUpdates = true;
  bool _darkMode = false;

  bool get pushNotifications => _pushNotifications;
  bool get emailPromotions => _emailPromotions;
  bool get orderUpdates => _orderUpdates;
  bool get darkMode => _darkMode;

  void togglePushNotifications(bool value) {
    _pushNotifications = value;
    notifyListeners();
  }

  void toggleEmailPromotions(bool value) {
    _emailPromotions = value;
    notifyListeners();
  }

  void toggleOrderUpdates(bool value) {
    _orderUpdates = value;
    notifyListeners();
  }

  void toggleDarkMode(bool value) {
    _darkMode = value;
    notifyListeners();
  }

  void changeLanguage(BuildContext context, String langCode) {
    context.setLocale(Locale(langCode));
    notifyListeners();
  }
}

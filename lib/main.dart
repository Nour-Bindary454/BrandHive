import 'package:brand/core/services/dio_helper.dart';
import 'package:brand/core/services/service_locator.dart';
import 'package:brand/my_app.dart';
import 'package:flutter/material.dart';
import 'package:brand/core/services/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();
  setup();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('de'),
        Locale('fr'),
      ],
      path:
          'assets/translations', // <-- change the path of the translation files
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

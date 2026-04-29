import 'package:brand/core/services/service_locator.dart';
import 'package:brand/my_app.dart';
import 'package:flutter/material.dart';
import 'package:brand/core/services/cache_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  setup();
  runApp(const MyApp());
}

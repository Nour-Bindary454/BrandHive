import 'package:brand/features/splash/presentation/views/splash_veiws.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
    
      home: Splash(),
    );
  }
}
import 'package:brand/core/services/cache_helper.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logout')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // مسح التوكن
            await CacheHelper.removeData("token");

            //الرجوع لصفحة اللوجين ومسح كل الشاشات
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}

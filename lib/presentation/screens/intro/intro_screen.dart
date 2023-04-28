import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:service_app/presentation/routes/app_screens.dart';
import 'package:service_app/presentation/utils/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          'Hello',
          style: TextStyle(fontSize: 32, color: AppColor.primary),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
        child: ElevatedButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('isNotFirstTime', true);
            Get.offAndToNamed(Routes.home);
          },
          child: const Text('Next'),
        ),
      ),
    );
  }
}

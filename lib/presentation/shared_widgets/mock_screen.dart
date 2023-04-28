import 'package:flutter/material.dart';
import 'package:service_app/presentation/utils/app_color.dart';
import 'package:service_app/presentation/shared_widgets/navigation.dart';

class MockScreen extends StatelessWidget {
  final String title;
  final int index;
  const MockScreen({super.key, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.silver,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(title),
      ),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 32, color: AppColor.primary),
        ),
      ),
      bottomNavigationBar: AppBottomNavigationBar(currentIndex: index),
    );
  }
}

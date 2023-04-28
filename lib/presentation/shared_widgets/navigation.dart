import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:service_app/presentation/routes/app_screens.dart';
import 'package:service_app/presentation/utils/app_color.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const AppBottomNavigationBar({super.key, required this.currentIndex});
  @override
  Widget build(BuildContext context) {
    List<String> screenList = [
      Routes.home,
      Routes.explore,
      Routes.chat,
      Routes.notification
    ];

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(canvasColor: AppColor.white),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (index != currentIndex) {
              Get.offAndToNamed(screenList[index]);
            }
          },
          selectedItemColor: AppColor.primary,
          unselectedItemColor: AppColor.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_outlined),
              label: 'Notification',
            ),
          ],
        ),
      ),
    );
  }
}

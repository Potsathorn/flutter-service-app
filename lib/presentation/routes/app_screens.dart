import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:service_app/presentation/screens/home/home_screen.dart';
import 'package:service_app/presentation/screens/home/service_detail.dart';
import 'package:service_app/presentation/screens/home/service_list.dart';
import 'package:service_app/presentation/screens/home/service_option.dart';
import 'package:service_app/presentation/screens/intro/intro_screen.dart';
import 'package:service_app/presentation/shared_widgets/mock_screen.dart';

part 'app_routes.dart';

class AppScreens {
  static const intro = Routes.intro;
  static const initial = Routes.home;

  static final routes = [
    GetPage(
        name: Routes.home,
        page: () => const HomeScreen(),
        transition: Transition.noTransition,
        children: [
          GetPage(
              name: '/serviceList',
              page: () => const ServiceListScreen(),
              children: [
                GetPage(
                    name: '/serviceDetail',
                    page: () => const ServiceDetail(),
                    children: [
                      GetPage(
                          name: '/serviceOption',
                          page: () => const ServiceOptionScreen())
                    ])
              ]),
        ]),
    GetPage(
      name: Routes.intro,
      page: () => const IntroScreen(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.explore,
      page: () => const MockScreen(
        title: 'Explore',
        index: 1,
      ),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.chat,
      page: () => const MockScreen(
        title: 'Chat',
        index: 2,
      ),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.notification,
      page: () => const MockScreen(
        title: 'Notification',
        index: 3,
      ),
      transition: Transition.noTransition,
    ),
  ];
}

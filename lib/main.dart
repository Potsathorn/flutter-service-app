import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_app/presentation/provider/shop_data/shop_data_notifier.dart';
import 'package:service_app/presentation/routes/app_screens.dart';
import 'package:service_app/presentation/screens/home/home_screen.dart';
import 'package:service_app/presentation/screens/intro/intro_screen.dart';
import 'package:service_app/presentation/utils/app_color.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'injection.dart' as di;
import 'presentation/provider/service_data/service_data_notifier.dart';

Future<void> main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isNotFirstTime = prefs.getBool('isNotFirstTime') ?? false;
  runApp(MyApp(isNotFirstTime: isNotFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isNotFirstTime;
  const MyApp({super.key, required this.isNotFirstTime});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => di.locator<ShopDataNotifier>()),
        ChangeNotifierProvider(
            create: (context) => di.locator<ServiceDataNotifier>())
      ],
      child: GetMaterialApp(
        title: 'Sevice App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                backgroundColor: AppColor.primary,
                titleTextStyle: TextStyle(
                    fontFamily: GoogleFonts.baloo2().fontFamily,
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            primaryColor: AppColor.primary,
            scaffoldBackgroundColor: AppColor.background,
            backgroundColor: AppColor.background,
            disabledColor: AppColor.primary.withOpacity(0.7),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary)),
            buttonTheme: const ButtonThemeData(buttonColor: AppColor.primary),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: AppColor.primary),
            textTheme: GoogleFonts.baloo2TextTheme(textTheme).copyWith(
              bodyText1: GoogleFonts.baloo2(
                textStyle: textTheme.bodyText1,
                color: AppColor.text,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
              bodyText2: GoogleFonts.baloo2(
                textStyle: textTheme.bodyText2,
                color: AppColor.text,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
              button: GoogleFonts.baloo2(
                textStyle: textTheme.button,
                color: AppColor.text,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            )),
        builder: EasyLoading.init(),
        home: isNotFirstTime ? const HomeScreen() : const IntroScreen(),
        // initialRoute: AppScreens.initial,
        getPages: AppScreens.routes,
      ),
    );
  }
}

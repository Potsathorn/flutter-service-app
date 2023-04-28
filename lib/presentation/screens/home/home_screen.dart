import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:service_app/presentation/provider/shop_data/shop_data_notifier.dart';
import 'package:service_app/presentation/provider/shop_data/shop_data_state.dart';
import 'package:service_app/presentation/routes/app_screens.dart';
import 'package:service_app/presentation/utils/app_color.dart';
import 'package:service_app/presentation/shared_widgets/navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final priceDataNotifier =
        Provider.of<ShopDataNotifier>(context, listen: false);
    priceDataNotifier.getShopData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shopDataNotifier = Provider.of<ShopDataNotifier>(context);
    final state = shopDataNotifier.shopDataState;
    return Scaffold(
      backgroundColor: AppColor.silver,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(child: () {
        if (state is ShopDataHasData) {
          final dataState = shopDataNotifier.shopDataState as ShopDataHasData;
          final data = dataState.shopData;
          final logoUrl = data.logoUrl;
          final shopName = data.shopName;
          final categories = data.categories;
          final isOpen = data.isOpen;
          final time = isOpen ? data.closeTime : data.openTime;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _shopData(
                  logoUrl: logoUrl,
                  shopName: shopName,
                  categories: categories,
                  isOpen: isOpen,
                  time: time),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIcon(
                      iconData: Icons.book_online_outlined, text: 'Booking'),
                  _buildIcon(
                      iconData: Icons.delivery_dining_outlined,
                      text: 'Delivery'),
                  _buildIcon(iconData: Icons.food_bank_outlined, text: 'Food'),
                  _buildIcon(
                      iconData: Icons.settings_outlined, text: 'Settings'),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildIcon(
                      iconData: Icons.favorite_border_outlined,
                      text: 'Favorite'),
                  _buildIcon(
                      iconData: Icons.shopping_cart_outlined, text: 'Cart'),
                  _buildIcon(
                      iconData: Icons.storefront_outlined,
                      text: 'My Service',
                      onTap: () => Get.toNamed(Routes.serviceList)),
                  _buildIcon(
                      iconData: Icons.help_outline_outlined, text: 'Help'),
                ],
              ),
              const SizedBox(height: 32),
            ],
          );
        } else if (state is ShopDataLoading) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(40.0),
            child: CircularProgressIndicator(
              color: AppColor.primary,
              strokeWidth: 5,
            ),
          ));
        } else if (state is ShopDataEmpty) {
          return _textState("Data no found");
        } else if (state is ShopDataError) {
          final error = state.message;
          return _textState(error);
        } else {
          return _textState("Something went wrong");
        }
      }()),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _shopData(
          {required String logoUrl,
          required String shopName,
          required List<String> categories,
          required bool isOpen,
          required String time}) =>
      Container(
        color: AppColor.white,
        height: 150,
        width: Get.width,
        margin: const EdgeInsets.only(bottom: 32),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Stack(children: [
              CircleAvatar(
                backgroundColor: AppColor.softGrey,
                radius: 50.0,
                backgroundImage: NetworkImage(logoUrl),
              ),
              const Positioned(
                  right: 0.5,
                  bottom: 0.5,
                  child: Icon(
                    Icons.verified_rounded,
                    color: AppColor.success,
                  ))
            ]),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    shopName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.text,
                        fontSize: 20),
                  ),
                  Text(
                    "\$\$•${categories.map((item) => "$item•").join()}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColor.softGrey,
                        fontSize: 16),
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: isOpen ? 'Open' : 'Closes',
                          style: TextStyle(
                            fontFamily: GoogleFonts.baloo2().fontFamily,
                            fontSize: 16,
                            color: isOpen ? AppColor.success : AppColor.failure,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: '•${!isOpen ? 'Open' : 'Closes'} $time',
                          style: TextStyle(
                            fontFamily: GoogleFonts.baloo2().fontFamily,
                            fontSize: 16,
                            color: AppColor.softGrey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      );

  Widget _buildIcon(
      {required IconData iconData,
      required String text,
      void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: Get.width / 4,
        child: Column(
          children: [
            Icon(
              iconData,
              size: 35,
              color: AppColor.darkGrey,
            ),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(
                  color: AppColor.darkGrey, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textState(String state) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(40.0),
      child: Text(state),
    ));
  }
}

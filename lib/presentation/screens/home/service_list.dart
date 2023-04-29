import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:service_app/presentation/provider/service_data/service_data_notifier.dart';
import 'package:service_app/presentation/provider/shop_data/shop_data_notifier.dart';
import 'package:service_app/presentation/provider/shop_data/shop_data_state.dart';
import 'package:service_app/presentation/routes/app_screens.dart';
import 'package:service_app/presentation/utils/app_color.dart';
import 'package:service_app/presentation/shared_widgets/toggle_switch.dart';
import 'package:service_app/presentation/utils/helper.dart';

class ServiceListScreen extends StatefulWidget {
  const ServiceListScreen({super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  @override
  void initState() {
    super.initState();
    log("list page created");
    final priceDataNotifier =
        Provider.of<ServiceDataNotifier>(context, listen: false);
    priceDataNotifier.clearService();
    priceDataNotifier.getServiceData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _gotoServiceDetail(dynamic argument) {
    Get.toNamed(Routes.serviceDetail, arguments: argument);
  }

  void _showOptions() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        final priceDataNotifier =
            Provider.of<ServiceDataNotifier>(context, listen: false);
        return _sortBy(onTapName: () {
          priceDataNotifier.sortByName();
          Get.back();
        }, onTapTime: () {
          priceDataNotifier.sortByTime();
          Get.back();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final shopDataNotifier = Provider.of<ShopDataNotifier>(context);
    final serviceDataNotifier = Provider.of<ServiceDataNotifier>(context);
    final dataState = shopDataNotifier.shopDataState as ShopDataHasData;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service List"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(serviceDataNotifier.serviceDataList.length),
            const Divider(),
            Text(dataState.shopData.shopName,
                style: const TextStyle(fontSize: 20)),
            const Divider(),
            serviceDataNotifier.serviceDataList.isEmpty
                ? SizedBox(
                    width: Get.width,
                    height: Get.height * 0.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_noService()],
                    ),
                  )
                : Column(
                    children: [
                      for (int i = 0;
                          i < serviceDataNotifier.serviceDataList.length;
                          i++)
                        _serviceCard(
                            title: serviceDataNotifier.serviceDataList[i].name,
                            price: serviceDataNotifier.serviceDataList[i].price,
                            isActive:
                                serviceDataNotifier.serviceDataList[i].isActive,
                            onTap: () => _gotoServiceDetail({
                                  'service':
                                      serviceDataNotifier.serviceDataList[i]
                                }),
                            onToggle: (bool isOn) => serviceDataNotifier
                                .updateStatus(index: i, status: isOn))
                    ],
                  )
          ],
        ),
      )),
    );
  }

  Widget _header(int item) => Row(
        children: [
          Expanded(
              child: Text(
            "$item item",
            style: const TextStyle(
                color: AppColor.grey, fontWeight: FontWeight.w600),
          )),
          OutlinedButton(
            onPressed: () => _showOptions(),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColor.grey),
              foregroundColor: AppColor.softGrey,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            child: Row(
              children: const [
                Text(
                  'Sort By',
                  style: TextStyle(
                    color: AppColor.grey,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: AppColor.grey,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          OutlinedButton(
            onPressed: () => _gotoServiceDetail(null),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: const BorderSide(color: AppColor.primary),
            ),
            child: const Text(
              '+ Create Service',
              style: TextStyle(
                color: AppColor.primary,
              ),
            ),
          )
        ],
      );

  Widget _noService() => Column(
        children: [
          const Text("No Service Created"),
          SizedBox(
            width: Get.width / 2.5,
            child: ElevatedButton(
              onPressed: () => _gotoServiceDetail(null),
              child: const Text("+ Create Service"),
            ),
          ),
        ],
      );

  Widget _serviceCard(
          {required String title,
          required double price,
          required bool isActive,
          void Function()? onTap,
          required void Function(bool) onToggle}) =>
      InkWell(
        onTap: onTap,
        child: Container(
          height: 120,
          width: Get.width,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.accent,
                ),
                child: const Icon(
                  Icons.yard_outlined,
                  color: AppColor.primary,
                  size: 60,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        )),
                    Text("${Helper.priceFormat(price)} THB",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ))
                  ],
                ),
              ),
              SizedBox(
                child: ToggleSwitch(
                  initState: isActive,
                  onToggle: onToggle,
                ),
              )
            ],
          ),
        ),
      );

  Widget _sortBy(
          {required void Function() onTapName,
          required void Function() onTapTime}) =>
      Container(
        decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: AppColor.lightGrey,
                ),
                padding: const EdgeInsets.all(1),
                child: Row(
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text("Sort By",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                    ),
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close))
                  ],
                )),
            ListTile(
                title: const Text(
                  'Service Name',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                onTap: onTapName),
            ListTile(
              title: const Text('Created Date',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: onTapTime,
            ),
          ],
        ),
      );
}

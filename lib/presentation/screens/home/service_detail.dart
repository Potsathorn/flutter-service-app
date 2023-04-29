import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:service_app/domain/entities/service_data.dart';
import 'package:service_app/presentation/provider/service_data/service_data_notifier.dart';
import 'package:service_app/presentation/routes/app_screens.dart';
import 'package:service_app/presentation/utils/app_color.dart';
import 'package:service_app/presentation/utils/helper.dart';
import 'package:service_app/presentation/shared_widgets/input.dart';
import 'package:service_app/presentation/shared_widgets/toggle_navbar.dart';
import 'package:service_app/presentation/shared_widgets/toggle_switch.dart';

class ServiceDetail extends StatefulWidget {
  const ServiceDetail({super.key});

  @override
  State<ServiceDetail> createState() => _ServiceDetailState();
}

class _ServiceDetailState extends State<ServiceDetail> {
  final _detailKey = GlobalKey();
  final _optionsKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController =
      TextEditingController(text: "Bangkok, Thailand");

  List<IconData> imgList = [
    Icons.star,
    Icons.surfing,
    Icons.monitor_heart_outlined,
    Icons.ac_unit_sharp
  ];

  bool _isOn = true;
  bool _isCreate = true;
  dynamic arguments = Get.arguments ?? {};
  ServiceData? _service;

  @override
  void initState() {
    _service = arguments['service'];
    if (_service != null) {
      _isCreate = false;
      _nameController.text = _service!.name;
      _descriptionController.text = _service!.description;
      _urlController.text = _service!.website;
      _priceController.text = Helper.priceFormat(_service!.price);
      _isOn = _service!.isActive;
    }
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _urlController.dispose();
    _locationController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final serviceDataNotifier = Provider.of<ServiceDataNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Detail"),
        actions: [
          if (!_isCreate)
            IconButton(
                onPressed: () async {
                  await Get.dialog(_deleteAlertDialog(onTapCancel: () {
                    Get.back();
                  }, onTapDelete: () async {
                    serviceDataNotifier.deleteServiceData(_service!.id);
                    Get.offNamedUntil(
                        Routes.serviceList, (route) => route.isFirst);
                  }));
                },
                icon: const Icon(
                  Icons.delete_outline,
                  size: 30,
                ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                _card(key: _detailKey, children: [
                  _header(
                      icon: Icons.calendar_today_outlined,
                      title: 'Service Detail'),
                  _addMedia(photoList: imgList),
                  Input(title: "Service Name", controller: _nameController),
                  Input(
                      title: "Description",
                      controller: _descriptionController,
                      isOptional: true,
                      maxLines: 3),
                  Input(
                      title: "Vanue Location",
                      controller: _locationController,
                      readOnly: true,
                      suffixIcon: const Icon(Icons.location_on_outlined)),
                  _map(),
                  Input(
                      title: "Website URL",
                      controller: _urlController,
                      isOptional: true),
                  Input(title: "Price", controller: _priceController),
                  _activeSwitch()
                ]),
                _card(
                    key: _optionsKey,
                    margin: const EdgeInsets.only(top: 10),
                    children: [
                      _header(title: 'Service Options', icon: Icons.list),
                      for (int i = 0; i < 3; i++)
                        _option(title: "Face Charn", price: 2000),
                      TextButton(
                          onPressed: () => Get.toNamed(Routes.serviceOption),
                          child: const Text(
                            "+ Add Another Option",
                            style: TextStyle(color: AppColor.primary),
                          ))
                    ]),
                const SizedBox(height: 2),
                _submit(onPressed: () {
                  {
                    ServiceData service = ServiceData(
                        id: _isCreate ? "" : _service!.id,
                        time: _isCreate ? DateTime.now() : _service!.time,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        location: _locationController.text,
                        website: _urlController.text,
                        isActive: _isOn,
                        price: double.tryParse(
                                _priceController.text.replaceAll(',', '')) ??
                            0,
                        image: [],
                        option: []);
                    _isCreate
                        ? serviceDataNotifier.insertServiceData(service)
                        : serviceDataNotifier.updateServiceData(service);
                    Get.offNamedUntil(
                        Routes.serviceList, (route) => route.isFirst);
                  }
                })
              ],
            ),
          ),
          ToggleNavbar(
            firstOptions: "Service Detail",
            secondOptions: "Service Options",
            onToggle: (bool value) {
              !value
                  ? Scrollable.ensureVisible(_detailKey.currentContext!,
                      duration: const Duration(milliseconds: 700))
                  : Scrollable.ensureVisible(_optionsKey.currentContext!,
                      duration: const Duration(milliseconds: 700));
            },
          )
        ]),
      ),
    );
  }

  Widget _card(
          {required Key key,
          EdgeInsetsGeometry? margin,
          List<Widget> children = const <Widget>[]}) =>
      Container(
        key: key,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: margin ?? const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: children),
        ),
      );
  Widget _addMedia({List<IconData> photoList = const <IconData>[]}) => Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          DottedBorder(
            dashPattern: const [6, 6],
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            color: AppColor.primary,
            strokeWidth: 1.5,
            child: SizedBox(
              height: Get.width * 0.28,
              width: Get.width,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.image,
                      color: AppColor.primary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Add Photo or Video",
                        style: TextStyle(color: AppColor.primary))
                  ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (int i = 0; i < photoList.length; i++)
                _childMedia(
                  child: Icon(
                    imgList[i],
                    color: AppColor.primary,
                  ),
                  isCoverPage: i == 0,
                  hideMargin: i == photoList.length,
                  onTapDelete: () {
                    imgList.removeAt(i);
                    setState(() {});
                  },
                )
            ],
          )
        ],
      );
  Widget _childMedia(
      {bool hideMargin = false,
      bool isCoverPage = false,
      required Widget child,
      void Function()? onTapDelete}) {
    final double width = Get.width;
    final double size = width / 5.25;
    final double rightMargin = (width - (4 * size)) / 13;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          Stack(clipBehavior: Clip.none, children: [
            InkWell(
              onTap: () => Get.dialog(_showPhotoDialog(child)),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.accent,
                ),
                child: child,
              ),
            ),
            if (isCoverPage)
              Positioned(
                left: 5,
                right: 5,
                bottom: 5,
                child: Container(
                  color: AppColor.white.withOpacity(0.7),
                  padding: const EdgeInsets.all(2),
                  child: const Text(
                    "Cover Photo",
                    style: TextStyle(fontSize: 10, color: AppColor.grey),
                  ),
                ),
              ),
            Positioned(
              top: -5,
              right: -5,
              child: InkWell(
                onTap: onTapDelete,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    size: 15,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ]),
          SizedBox(width: hideMargin ? 0 : rightMargin),
        ],
      ),
    );
  }

  Widget _header({required String title, required IconData icon}) => Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColor.secondary,
            child: Icon(
              icon,
              color: AppColor.white,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      );

  Widget _activeSwitch() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          const Text(
            'Active / Inactive',
            style: TextStyle(fontSize: 16.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ToggleSwitch(
                initState: _isOn,
                onToggle: (isOn) {
                  _isOn = isOn;
                },
                color: AppColor.primary,
              ),
              const SizedBox(
                width: 3,
              ),
              const Expanded(
                child: Text(
                  'Active(User will be able to see in Shop)',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _map() => Container(
        height: Get.width / 2.3,
        width: Get.width,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: AppColor.lightGrey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.location_on_outlined,
          size: 40,
          color: AppColor.softGrey,
        ),
      );
  Widget _option({required String title, required double price}) => InkWell(
        onTap: (() => Get.toNamed(Routes.serviceOption)),
        child: Container(
          width: Get.width,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: AppColor.accent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(child: Text(title)),
              const SizedBox(
                width: 5,
              ),
              Text("${Helper.priceFormat(price)} THB")
            ],
          ),
        ),
      );
  Widget _showPhotoDialog(Widget content) => AlertDialog(
        //title: const Center(child: Text('Photo')),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            content,
          ],
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColor.white,
              backgroundColor: AppColor.primary,
            ),
            child: const Text('OK'),
          )
        ],
      );

  Widget _deleteAlertDialog(
          {required void Function() onTapCancel,
          required void Function() onTapDelete}) =>
      AlertDialog(
        title: Container(
            alignment: Alignment.center,
            child: const Text('Delete this Service')),
        content: Container(
            height: 20,
            alignment: Alignment.center,
            child: const Text('Confirm to delete this service')),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          TextButton(
            onPressed: onTapCancel,
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColor.primary),
            ),
          ),
          ElevatedButton(
            onPressed: onTapDelete,
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColor.white,
              backgroundColor: AppColor.failure,
            ),
            child: const Text('Delete'),
          )
        ],
      );

  Widget _submit({required void Function()? onPressed}) => Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(_isCreate ? "publish" : "save"),
        ),
      );
}

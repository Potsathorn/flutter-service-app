import 'package:flutter/material.dart';
import 'package:service_app/presentation/utils/app_color.dart';

class ToggleNavbar extends StatefulWidget {
  final ValueChanged<bool> onToggle;
  final String firstOptions;
  final String secondOptions;

  const ToggleNavbar(
      {super.key,
      required this.onToggle,
      required this.firstOptions,
      required this.secondOptions});

  @override
  // ignore: library_private_types_in_public_api
  _ToggleNavbarState createState() => _ToggleNavbarState();
}

class _ToggleNavbarState extends State<ToggleNavbar> {
  bool isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isToggled = false;
            });
            widget.onToggle(isToggled);
          },
          child: Container(
            height: 40,
            color: AppColor.background,
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Text(
                  widget.firstOptions,
                  style: TextStyle(
                      color: !isToggled ? AppColor.primary : AppColor.text),
                ),
                Container(
                  height: 3,
                  width: 90,
                  decoration: BoxDecoration(
                    color: !isToggled ? AppColor.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                )
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              isToggled = true;
            });
            widget.onToggle(isToggled);
          },
          child: Container(
            height: 40,
            color: AppColor.background,
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Text(
                  widget.secondOptions,
                  style: TextStyle(
                      color: isToggled ? AppColor.primary : AppColor.text),
                ),
                Container(
                  height: 3,
                  width: 90,
                  decoration: BoxDecoration(
                    color: isToggled ? AppColor.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 40,
            color: AppColor.background,
          ),
        )
      ],
    );
  }
}

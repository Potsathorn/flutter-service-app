import 'package:flutter/material.dart';
import 'package:service_app/presentation/utils/app_color.dart';

class ToggleSwitch extends StatefulWidget {
  final bool initState;
  final ValueChanged<bool> onToggle;
  final Color? color;

  const ToggleSwitch(
      {super.key, required this.onToggle, this.color, this.initState = true});

  @override
  // ignore: library_private_types_in_public_api
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  late bool isToggled;
  @override
  void initState() {
    isToggled = widget.initState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isToggled = !isToggled;
        });
        widget.onToggle(isToggled);
      },
      child: Container(
        height: 25,
        width: 52,
        padding: const EdgeInsets.all(4),
        alignment: isToggled ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isToggled ? widget.color ?? AppColor.success : AppColor.silver,
        ),
        child: Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

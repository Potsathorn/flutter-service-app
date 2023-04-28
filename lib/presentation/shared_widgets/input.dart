import 'package:flutter/material.dart';
import 'package:service_app/presentation/utils/app_color.dart';

class Input extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isOptional;
  final bool showDelete;
  final int? maxLines;
  final bool readOnly;
  final Widget? suffixIcon;

  const Input(
      {super.key,
      required this.title,
      required this.controller,
      this.isOptional = false,
      this.showDelete = false,
      this.maxLines,
      this.readOnly = false,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10.0),
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            if (isOptional)
              const Text(
                ' (Optional)',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: controller,
                style: const TextStyle(fontWeight: FontWeight.w500),
                readOnly: readOnly,
                maxLines: maxLines,
                decoration: InputDecoration(
                  hintText: "Enter $title",
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  suffixIcon: suffixIcon,
                  border: const OutlineInputBorder(),
                ),
                validator: isOptional ? null : (value) {},
              ),
            ),
            if (showDelete)
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColor.softGrey,
                  ))
          ],
        ),
      ],
    );
  }
}

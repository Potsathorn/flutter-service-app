import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_app/presentation/shared_widgets/input.dart';
import 'package:service_app/presentation/utils/app_color.dart';

class ServiceOptionScreen extends StatelessWidget {
  const ServiceOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Service Options"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < 3; i++) const OptionForm(),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "+ Add Another Option",
                    style: TextStyle(color: AppColor.primary),
                  )),
              _submit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _submit() => Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 45,
          width: Get.width,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Confirm option'),
          ),
        ),
      );
}

class OptionForm extends StatefulWidget {
  const OptionForm({super.key});

  @override
  State<OptionForm> createState() => _OptionFormState();
}

class _OptionFormState extends State<OptionForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Input(
            title: "Option Name",
            controller: _nameController,
            showDelete: true),
        Input(
            title: "Option Description",
            controller: _descriptionController,
            maxLines: 3),
        Input(
          title: "Price",
          controller: _priceController,
          suffixIcon: const Padding(
            padding: EdgeInsets.all(11.0),
            child: Text("THB"),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        const Divider(
          color: AppColor.softGrey,
        )
      ],
    );
  }
}

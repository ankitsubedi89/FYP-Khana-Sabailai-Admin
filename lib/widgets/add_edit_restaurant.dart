import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/controllers/restaurant_controller.dart';
import 'package:khana_sabailai_admin/widgets/custom_text_field.dart';

class AddEditRestaurant extends StatelessWidget {
  const AddEditRestaurant(
      {Key? key,
       this.pickBtn,
      required this.button,
      this.type = 'Add'})
      : super(key: key);

  final Widget? pickBtn;
  final Widget button;
  final String type;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantController>(builder: (controller) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      '$type Restaurant',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                if (controller.imageFile != null)
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: kIsWeb
                        ? Image.network(controller.imageFile?.path ?? '')
                        : Image.file(File(controller.imageFile?.path ?? '')),
                  ),
                pickBtn ?? const SizedBox.shrink(),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Restaurant Name',
                  controller: controller.nameController,
                  prefixIcon: const Icon(Icons.dining_sharp),
                ),
                if(type == 'Add')
                Column(
                  children: [
                    const SizedBox(height: 20),
                  
                CustomFormField(
                  label: 'Email',
                  controller: controller.emailController,
                  prefixIcon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Password',
                  controller: controller.passwordController,
                  prefixIcon: const Icon(Icons.password),
                  isObscure: true,
                ),],
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Contact',
                  controller: controller.contactController,
                  prefixIcon: const Icon(Icons.numbers),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Address',
                  controller: controller.addressController,
                  prefixIcon: const Icon(Icons.description),
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Latitude',
                  controller: controller.latController,
                  prefixIcon: const Icon(Icons.numbers),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Longitude',
                  controller: controller.lonController,
                  prefixIcon: const Icon(Icons.numbers),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                button
              ],
            ),
          ),
        ),
      );
    });
  }
}

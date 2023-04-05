import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/controllers/menu_controller.dart';
import 'package:khana_sabailai_admin/widgets/custom_text_field.dart';

class AddFoodDialog extends StatelessWidget {
  const AddFoodDialog(
      {Key? key,
      required this.pickBtn,
      required this.button,
      this.type = 'Add'})
      : super(key: key);

  final Widget pickBtn;
  final Widget button;
  final String type;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(builder: (controller) {
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
                      '$type Dish',
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
                pickBtn,
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Food Name',
                  controller: controller.foodNameController,
                  prefixIcon: const Icon(Icons.dining_sharp),
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Food Price',
                  controller: controller.foodPriceController,
                  prefixIcon: const Icon(Icons.money),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Food Quantity',
                  controller: controller.foodQuantityController,
                  prefixIcon: const Icon(Icons.numbers),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Food Description',
                  controller: controller.foodDescriptionController,
                  prefixIcon: const Icon(Icons.description),
                  lines: 5,
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

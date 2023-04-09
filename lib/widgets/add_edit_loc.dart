import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/widgets/custom_text_field.dart';
import 'package:khana_sabailai_admin/controllers/loc_controller.dart';

class AddEditLocDialog extends StatelessWidget {
  const AddEditLocDialog(
      {Key? key,
      required this.button,
      this.type = 'Add'})
      : super(key: key);

  final Widget button;
  final String type;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocController>(builder: (controller) {
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
                      '$type LOC',
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
                CustomFormField(
                  label: 'Name',
                  controller: controller.nameController,
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Contact',
                  controller: controller.contactController,
                  prefixIcon: const Icon(Icons.book),
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Email',
                  controller: controller.emailController,
                  prefixIcon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,
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

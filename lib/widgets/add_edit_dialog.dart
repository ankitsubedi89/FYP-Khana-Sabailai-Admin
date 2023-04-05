import 'package:flutter/material.dart';
import 'package:khana_sabailai_admin/widgets/custom_text_field.dart';

class AddEditDialog extends StatelessWidget {
  const AddEditDialog(
      {Key? key,
      required this.catNameController,
      required this.button,
      required this.type})
      : super(key: key);

  final TextEditingController catNameController;
  final Widget button;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '$type Category',
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
              label: 'Category Name',
              controller: catNameController,
              prefixIcon: const Icon(Icons.category),
            ),
            const SizedBox(height: 20),
            button
          ],
        ),
      ),
    );
  }
}

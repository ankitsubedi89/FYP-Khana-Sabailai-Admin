import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/controllers/loc_controller.dart';
import 'package:khana_sabailai_admin/widgets/add_edit_loc.dart';
import 'package:khana_sabailai_admin/widgets/custom_button.dart';

class LocScreen extends StatelessWidget {
  const LocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Leftover Companies'),
        actions: [
          GetBuilder<LocController>(builder: (controller) {
            return IconButton(
              onPressed: () {
                controller.nameController.clear();
                controller.contactController.clear();
                controller.emailController.clear();
                showDialog(
                    context: (context),
                    builder: (context) => AddEditLocDialog(
                          button: CustomButton(
                              label: 'Add Company',
                              onPressed: () {
                                controller.addLOCCompany(context);
                              }),
                        ));
              },
              icon: const Icon(Icons.add),
            );
          }),
        ],
      ),
      body: GetBuilder<LocController>(builder: (controller) {
        return Column(
          children: controller.loc
              .map(
                (e) => Slidable(
                  direction: Axis.horizontal,
                  endActionPane: ActionPane(
                    extentRatio: 0.8,
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (a) {
                          showDialog(
                              context: (context),
                              builder: (context) => AlertDialog(
                                    title: Text('Delete ${e.name}'),
                                    content: Text(
                                      'Are you sure you want to delete this company?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: ()async {
                                          await controller.deleteLOC(e.id);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                              );
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (a) {
                          controller.nameController.text = e.name!;
                          controller.contactController.text = e.contact!;
                          controller.emailController.text = e.email!;
                          controller.update();
                          showDialog(
                              context: (context),
                              builder: (context) => AddEditLocDialog(
                                    type: 'Edit',
                                    button: CustomButton(
                                        label: 'Edit Company',
                                        onPressed: () {
                                          controller.editLOCCompany(
                                              context, e.id);
                                        }),
                                  ));
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      )
                    ],
                  ),
                  child: ListTile(
                    tileColor: Colors.grey[200],
                    title: Text(e.name!),
                    subtitle: Text('${e.contact!}\n${e.email!}'),
                    isThreeLine: true,
                  ),
                ),
              )
              .toList(),
        );
      }),
    );
  }
}

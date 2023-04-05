import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/baseurl.dart';
import 'package:khana_sabailai_admin/controllers/menu_controller.dart';
import 'package:khana_sabailai_admin/models/category.dart';
import 'package:khana_sabailai_admin/models/restaurant.dart';
import 'package:khana_sabailai_admin/routes.dart';
import 'package:khana_sabailai_admin/widgets/add_edit_dialog.dart';
import 'package:khana_sabailai_admin/widgets/circular_btn.dart';
import 'package:khana_sabailai_admin/widgets/custom_button.dart';

class SingleRestaurant extends StatelessWidget {
  SingleRestaurant({Key? key}) : super(key: key);

  final Restaurant restaurant = Get.arguments[0];
  final bool fromNear = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Hero(
                tag: 'restaurant${restaurant.id}${fromNear ? 'near' : ''}',
                child: Image(
                  image: NetworkImage(baseurl + restaurant.image!),
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0x50000000),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurant.name!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: Color(0xff000000),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GetBuilder<MenuController>(builder: (controller) {
                          return CircularBtn(
                              color: Colors.black,
                              onTap: () {
                                controller.catNameController.clear();
                                controller.update();
                                showDialog(
                                  context: context,
                                  builder: (context) => AddEditDialog(
                                    catNameController:
                                        controller.catNameController,
                                    button: CustomButton(
                                      onPressed: () {
                                        controller.addCategory(context);
                                      },
                                      label: '+Add ',
                                    ),
                                    type: 'Add',
                                  ),
                                );
                              },
                              icon: Icons.add);
                        })
                      ],
                    ),
                    Text(
                      restaurant.address!,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Lat: ${restaurant.lat!}\nLong: ${restaurant.lon!}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder<MenuController>(builder: (controller) {
                      return Wrap(
                        children: controller.categories
                            .map((e) => InkWell(
                                  onTap: () {
                                    Get.toNamed(GetRoutes.categoryScreen,
                                        arguments: [e, restaurant]);
                                  },
                                  child: Stack(
                                    children: [
                                      CategoryCard(
                                        category: e,
                                      ),
                                      Positioned(
                                        left: 5,
                                        top: 5,
                                        child: GetBuilder<MenuController>(
                                          builder: (controller) {
                                            return Row(
                                              children: [
                                                CircularBtn(
                                                    color: Colors.black,
                                                    onTap: () {
                                                      controller
                                                          .catNameController
                                                          .text = e.name!;
                                                      controller.update();
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AddEditDialog(
                                                          catNameController:
                                                              controller
                                                                  .catNameController,
                                                          button: CustomButton(
                                                            onPressed: () {
                                                              controller
                                                                  .editCategory(
                                                                      context,
                                                                      e.id!);
                                                            },
                                                            label: 'Edit',
                                                          ),
                                                          type: 'Edit',
                                                        ),
                                                      );
                                                    },
                                                    icon: Icons.edit),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                if (controller
                                                    .getFilteredMenu(e.id, null)
                                                    .isEmpty)
                                                  CircularBtn(
                                                      color: Colors.black,
                                                      onTap: () {
                                                        showDialog(
                                                            context: (context),
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    'Delete Category'),
                                                                content: const Text(
                                                                    'Are you sure you want to delete this category?'),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                    child: const Text(
                                                                        'Cancel'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      controller
                                                                          .deleteCategory(
                                                                              e.id);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        'Delete'),
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      icon: Icons.delete),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      );
                    })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
      width: MediaQuery.of(context).size.width / 2.3,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Text(
        category.name!,
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xff000000),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

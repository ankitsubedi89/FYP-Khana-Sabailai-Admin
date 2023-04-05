import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/controllers/main_controller.dart';
import 'package:khana_sabailai_admin/controllers/menu_controller.dart';
import 'package:khana_sabailai_admin/widgets/circular_btn.dart';
import 'package:khana_sabailai_admin/widgets/content_head.dart';
import 'package:khana_sabailai_admin/widgets/custom_search_field.dart';
import 'package:khana_sabailai_admin/widgets/restaurant_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SvgPicture.asset(
              'assets/svg/logo.svg',
              color: Colors.black,
              fit: BoxFit.contain,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ContentHead(
                  title: 'All Restaurants',
                ),
                const SizedBox(height: 10),
                CustomSearchField(onChanged: (val) {
                  controller.search(val);
                }),
                const SizedBox(height: 20),
                Wrap(
                  children: controller.filteredRestaurants
                      .map((restaurant) => Stack(
                            children: [
                              RestaurantCard(
                                height: 112,
                                marginRight: 5,
                                marginBottom: 10,
                                restaurant: restaurant,
                              ),
                              Positioned(
                                left: 5,
                                top: 5,
                                child: GetBuilder<MenuController>(
                                  builder: (controller) {
                                    return Row(
                                      children: [
                                        CircularBtn(
                                            onTap: () {
                                              // controller.foodNameController
                                              //     .text = menu.food!;
                                              // controller.foodPriceController
                                              //     .text = menu.price!;
                                              // controller.foodQuantityController
                                              //     .text = menu.quantity!;
                                              // controller
                                              //     .foodDescriptionController
                                              //     .text = menu.description!;
                                              // controller.imageFile = null;
                                              // controller.update();
                                              // showDialog(
                                              //     context: (context),
                                              //     builder: (context) {
                                              //       return AddFoodDialog(
                                              //         type: 'Edit',
                                              //         pickBtn: CustomButton(
                                              //           onPressed: () {
                                              //             controller
                                              //                 .pickImage();
                                              //           },
                                              //           label: 'Pick Image',
                                              //         ),
                                              //         button: CustomButton(
                                              //           onPressed: () {
                                              //             controller.editDish(
                                              //                 context,
                                              //                 menu.id!);
                                              //           },
                                              //           label: 'Edit Dish',
                                              //         ),
                                              //       );
                                              //     });
                                            },
                                            icon: Icons.edit),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CircularBtn(
                                            onTap: () {
                                              // showDialog(
                                              //     context: (context),
                                              //     builder: (context) =>
                                              //         AlertDialog(
                                              //           title: Text(
                                              //               '${menu.isDeleted == '1' ? 'Restore ' : 'Delete'} Dish'),
                                              //           content: Text(
                                              //               'Are you sure you want to ${menu.isDeleted == '1' ? 'restore ' : 'delete'} this dish?'),
                                              //           actions: [
                                              //             TextButton(
                                              //                 onPressed: () {
                                              //                   Navigator.pop(
                                              //                       context);
                                              //                 },
                                              //                 child: const Text(
                                              //                     'No')),
                                              //             TextButton(
                                              //                 onPressed: () {
                                              //                   controller.deleteDish(
                                              //                       context,
                                              //                       menu.id!,
                                              //                       menu.isDeleted ==
                                              //                               '1'
                                              //                           ? true
                                              //                           : false);
                                              //                 },
                                              //                 child: const Text(
                                              //                     'Yes')),
                                              //           ],
                                              //         ));
                                            },
                                            icon: restaurant.isDeleted == '1'
                                                ? Icons.restore_from_trash
                                                : Icons.delete),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

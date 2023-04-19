import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/controllers/main_controller.dart';
import 'package:khana_sabailai_admin/controllers/menu_controller.dart'
    as mcontroller;
import 'package:khana_sabailai_admin/controllers/restaurant_controller.dart';
import 'package:khana_sabailai_admin/widgets/add_edit_restaurant.dart';
import 'package:khana_sabailai_admin/widgets/circular_btn.dart';
import 'package:khana_sabailai_admin/widgets/content_head.dart';
import 'package:khana_sabailai_admin/widgets/custom_button.dart';
import 'package:khana_sabailai_admin/widgets/custom_search_field.dart';
import 'package:khana_sabailai_admin/widgets/restaurant_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (controller) {
      return GetBuilder<RestaurantController>(
        builder: (resController) {
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
              actions: [
                 IconButton(
                      onPressed: () {
                        resController.resetFields();
                        showDialog(
                              context: (context),
                              builder: (context) {
                                return AddEditRestaurant(
                                  pickBtn: CustomButton(
                                    onPressed: () {
                                      resController.pickImage();
                                    },
                                    label: 'Pick Image',
                                  ),
                                  button: CustomButton(
                                    onPressed: () {
                                      resController.addRestaurant(
                                          context);
                                    },
                                    label: 'Add Resaurant',
                                  ),
                                );
                              });
                      },
                      icon: const Icon(Icons.add),
                    )
                  
              ],
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
                                    child: GetBuilder<mcontroller.MenuController>(
                                      builder: (controller) {
                                        return Row(
                                          children: [
                                            CircularBtn(
                                                onTap: () {
                                                  resController.nameController.text = restaurant.name!;
                                                  resController.addressController.text = restaurant.address!;
                                                  resController.contactController.text = restaurant.contact!;
                                                  resController.latController.text = restaurant.lat!;
                                                  resController.lonController.text = restaurant.lon!;
                                                  resController.emailController.text = restaurant.email!;
                                                  resController.passwordController.text = restaurant.password!;

                                                  resController.imageFile = null;
                                                  showDialog(
                                                      context: (context),
                                                      builder: (context) {
                                                        return AddEditRestaurant(
                                                          type: 'Edit',
                                                          pickBtn: CustomButton(
                                                            onPressed: () {
                                                              controller
                                                                  .pickImage();
                                                            },
                                                            label: 'Pick Image',
                                                          ),
                                                          button: CustomButton(
                                                            onPressed: () {
                                                              resController.editRestaurant(
                                                                  context,
                                                                  restaurant.id!);
                                                            },
                                                            label: 'Edit Restaurant',
                                                          ),
                                                        );
                                                      });
                                                },
                                                icon: Icons.edit),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            CircularBtn(
                                                onTap: () {
                                                  showDialog(
                                                      context: (context),
                                                      builder: (context) =>
                                                          AlertDialog(
                                                            title: Text(
                                                                '${restaurant.isDeleted == '1' ? 'Restore ' : 'Delete'} Restaurant'),
                                                            content: Text(
                                                                'Are you sure you want to ${restaurant.isDeleted == '1' ? 'restore ' : 'delete'} this restaurant?'),
                                                            actions: [
                                                              TextButton(
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: const Text(
                                                                      'No')),
                                                              TextButton(
                                                                  onPressed: () {
                                                                    resController.deleteRestaurant(
                                                                        context,
                                                                        restaurant.id!,
                                                                        restaurant.isDeleted ==
                                                                                '1'
                                                                            ? true
                                                                            : false);
                                                                  },
                                                                  child: const Text(
                                                                      'Yes')),
                                                            ],
                                                          ));
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
        }
      );
    });
  }
}

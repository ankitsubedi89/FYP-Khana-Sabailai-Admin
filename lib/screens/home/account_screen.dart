import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/controllers/user_controller.dart';
import 'package:khana_sabailai_admin/baseurl.dart';
import 'package:khana_sabailai_admin/controllers/login_controller.dart';
import 'package:khana_sabailai_admin/routes.dart';
import 'package:khana_sabailai_admin/utils/decoration.dart';
import 'package:khana_sabailai_admin/widgets/custom_button.dart';
import 'package:khana_sabailai_admin/widgets/custom_text_field.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: GetBuilder<UserController>(builder: (controller) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(75),
                      child: Image(
                        fit: BoxFit.cover,
                        image: controller.user.image == '' ||
                                controller.user.image == null
                            ? const NetworkImage(
                                'https://ui-avatars.com/api/?background=random&name=Khana+Sabailai',
                              )
                            : NetworkImage(
                                baseurl + controller.user.image!,
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: EditIcon(
                      onPress: () {
                        controller.pickImage();
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: boxDecoration(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.user.name!,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            controller.user.address!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            controller.user.email!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            controller.user.contact!,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ]),
                  ),
                  Positioned(
                      top: -15,
                      right: -15,
                      child: EditIcon(
                        onPress: () {
                          showDialog(
                              context: (context),
                              builder: (context) {
                                return Dialog(
                                  child: EditProfile(
                                    nameController: controller.nameController,
                                    contactController:
                                        controller.contactController,
                                    addressController:
                                        controller.addressController,
                                    onEdit: () {
                                      controller.editUser(context);
                                    },
                                  ),
                                );
                              });
                        },
                      ))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(GetRoutes.reportScreen);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: boxDecoration(),
                    child: const Text(
                      'Orders Stats',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showDialog(
                      context: (context),
                      builder: (context) {
                        return const Dialog(child: ChangePassword());
                      });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: boxDecoration(),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<LoginController>(builder: (controller) {
                return CustomButton(
                    label: 'Logout',
                    onPressed: () {
                      controller.logoutUser(context);
                    });
              })
            ]),
          ),
        );
      }),
      // body: Center(child: GetBuilder<LoginController>(builder: (controller) {
      //   return CustomButton(
      //       label: 'Logout',
      //       onPressed: () {
      //         controller.logoutUser(context);
      //       });
      // })),
    );
  }
}

class EditIcon extends StatelessWidget {
  const EditIcon({super.key, required this.onPress});

  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress as void Function()?,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: const Color(0xff020578),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text(
            'Change Password',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomFormField(
            label: 'Old Password',
            isObscure: true,
            controller: controller.oldPasswordController,
            prefixIcon: const Icon(Icons.lock),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomFormField(
            label: 'New Password',
            isObscure: true,
            controller: controller.newPasswordController,
            prefixIcon: const Icon(Icons.lock),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomFormField(
            label: 'Confirm Password',
            isObscure: true,
            controller: controller.confirmPasswordController,
            prefixIcon: const Icon(Icons.lock),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
              label: 'Change',
              onPressed: () {
                controller.changePassword(context);
              }),
        ]),
      );
    });
  }
}

class EditProfile extends StatelessWidget {
  const EditProfile({
    Key? key,
    required this.nameController,
    required this.contactController,
    required this.addressController,
    required this.onEdit,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController contactController;
  final TextEditingController addressController;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              CustomFormField(
                prefixIcon: const Icon(Icons.person),
                label: 'Name',
                controller: nameController,
              ),
              const SizedBox(height: 10),
              const Text(
                'Contact',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              CustomFormField(
                  prefixIcon: const Icon(Icons.phone),
                  label: 'Contact',
                  controller: contactController),
              const SizedBox(height: 10),
              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              CustomFormField(
                prefixIcon: const Icon(Icons.location_pin),
                label: 'Address',
                controller: addressController,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      onEdit();
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}

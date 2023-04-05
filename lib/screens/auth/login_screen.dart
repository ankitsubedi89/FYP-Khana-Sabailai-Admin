import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_admin/controllers/login_controller.dart';
import 'package:khana_sabailai_admin/widgets/custom_button.dart';
import 'package:khana_sabailai_admin/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(builder: (controller) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                SvgPicture.asset(
                  'assets/svg/logo.svg',
                  width: 80,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    CustomFormField(
                      label: 'Email',
                      prefixIcon: const Icon(Icons.mail),
                      controller: controller.emailController,
                    ),
                    const SizedBox(height: 10),
                    CustomFormField(
                      label: 'Password',
                      prefixIcon: const Icon(Icons.key),
                      isObscure: true,
                      controller: controller.passwordController,
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                        label: 'Login',
                        onPressed: () {
                          controller.checkLogin();
                        })
                  ],
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      }),
    );
  }
}

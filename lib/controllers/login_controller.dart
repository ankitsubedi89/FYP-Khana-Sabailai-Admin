import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khana_sabailai_admin/baseurl.dart';
import 'package:khana_sabailai_admin/models/user.dart';
import 'package:khana_sabailai_admin/routes.dart';
import 'package:khana_sabailai_admin/utils/shared_prefs.dart';
import 'package:khana_sabailai_admin/utils/utils.dart';

class LoginController extends GetxController {
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    super.onInit();

    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  checkLogin() {
    if (emailController.text.isEmpty) {
      customGetSnackbar('*Email', 'Please enter your email.', 'error');
    } else if (GetUtils.isEmail(emailController.text) == false) {
      customGetSnackbar('*Email', 'Please enter valid email.', 'error');
    } else if (passwordController.text.isEmpty) {
      customGetSnackbar('*Password', 'Please enter your password.', 'error');
    } else {
      login();
      // Get.showOverlay(
      //     asyncFunction: () => login(), loadingWidget: const Loader());
    }
  }

  login() async {
    var response =
        await http.post(Uri.parse('${baseurl}users/login.php'), body: {
      'email': emailController.text,
      'password': passwordController.text,
      'is_admin': '1'
    });
    var res = await json.decode(response.body);
    if (res['success']) {
      User user = User.fromJson(res['data']);
      await SharedPrefs().storeUser(json.encode(user));
      emailController.clear();
      passwordController.clear();
      Get.offAllNamed(GetRoutes.bottomTab);
    } else {
      customGetSnackbar('Login up failed!', res['message'][0], 'error');
    }
  }

  logoutUser(context) async {
    showDialog(
        context: (context),
        builder: (context) {
          return AlertDialog(
            title: const Text('Logout?'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await SharedPrefs().removeUser();
                    Get.offAllNamed(GetRoutes.splash);
                  },
                  child: const Text('Confirm'))
            ],
          );
        });
  }
}

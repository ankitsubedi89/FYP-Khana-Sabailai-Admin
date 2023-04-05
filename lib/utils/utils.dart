import 'package:flutter/material.dart';
import 'package:get/get.dart';

customGetSnackbar(String title, String message, String type) {
  Get.snackbar(
    "",
    "",
    snackPosition: SnackPosition.TOP,
    backgroundColor: type == "error" ? Colors.red : Colors.green,
    colorText: Colors.white,
    borderRadius: 10,
    margin: const EdgeInsets.all(10),
    borderColor: type == "error" ? Colors.red : Colors.green,
    borderWidth: 1,
    duration: const Duration(seconds: 3),
    titleText: Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    ),
  );
}

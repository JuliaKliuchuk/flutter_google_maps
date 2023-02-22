import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar(
  String message, {
  bool isError = true,
  String title = 'Error',
}) {
  Get.snackbar(
    title,
    message,
    titleText: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    messageText: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent,
    duration: const Duration(seconds: 5),
  );
}

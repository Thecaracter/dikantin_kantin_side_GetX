import 'package:dikantin/app/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordController extends GetxController {
  //TODO: Implement ForgotPasswordController
  late TextEditingController emailController = TextEditingController();
  final ForgotPasswordProvider _provider = Get.put(ForgotPasswordProvider());

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  Future<void> forgotPassword({required String email}) async {
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email address.',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      );
    } else {
      try {
        await _provider.forgotPassword(email);
        await saveemail(email);
      } catch (error) {
        Get.snackbar(
          'Error',
          'An unexpected error occurred. Please try again later.',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
        print('Error: $error');
      }
    }
  }

  Future<String> saveemail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    return email;
  }
}

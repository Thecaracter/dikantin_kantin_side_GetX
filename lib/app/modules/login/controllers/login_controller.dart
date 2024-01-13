import 'package:dikantin_o_l_d/app/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/providers/login_provider.dart';

class LoginController extends GetxController {
  final loginProvider = LoginProvider().obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    NotificationService notificationService = NotificationService();
    var token = await notificationService.getDeviceToken();
    // save token ketika login view di render
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('tokenFcm', token);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // login dan juga obsecure
  final RxBool obscureText = true.obs;
  final RxBool isLoading = false.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  Future<void> login(String email, String password, String fcmToken) async {
    print("object");
    try {
      final response =
          await loginProvider.value.loginKantin(email, password, fcmToken);

      if (response.statusCode == 200) {
        Get.offAllNamed('/navigation');
      } else {
        Get.snackbar(
          'Login Gagal',
          'Username atau Password salah',
          backgroundColor: Colors.red, // Warna latar belakang
          colorText: Colors.white, // Warna teks
          duration: Duration(seconds: 2), // Durasi Snackbar
          snackPosition: SnackPosition.BOTTOM, // Posisi Snackbar
        );
      }
    } catch (error) {
      // Tangani pengecualian di sini, jika diperlukan
      print('An error occurred: $error');
    } finally {}
  }
}

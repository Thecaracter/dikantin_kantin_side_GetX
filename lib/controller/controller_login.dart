import 'package:dikantin/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/login_provider.dart';

class LoginKantinController extends GetxController {
  final loginProvider = LoginProvider().obs;
  Future<void> login(String email, String password, String fcmToken) async {
    print("object");
    try {
      final response =
          await loginProvider.value.loginKantin(email, password, fcmToken);

      if (response.statusCode == 200) {
        Get.offAll(Navigation());
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

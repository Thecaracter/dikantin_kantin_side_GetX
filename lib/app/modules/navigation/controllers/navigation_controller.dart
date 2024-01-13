import 'dart:convert';

import 'package:dikantin/app/data/providers/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

class NavigationController extends GetxController {
  //TODO: Implement NavigationController
  var tabIndex = 0;
  @override
  void onInit() {
    super.onInit();
    checkToken();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Tambahkan metode untuk memperbarui currentScreen
  void updateCurrentScreen(int index) {
    tabIndex = index;
    update();
  }

  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id_customer = prefs.getString('id_customer');

    try {
      final response = await http.post(
        Uri.parse(Api.getToken),
        body: {
          'id_customer':
              id_customer, // Ganti dengan informasi unik dari pengguna
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final newToken = jsonResponse['data']['token'];

        // Bandingkan token yang ada dengan newToken
        String? existingToken = prefs.getString('token');
        if (existingToken != newToken) {
          // Token tidak sesuai, tampilkan dialog untuk login ulang
          _showLogoutDialog();
        } else {
          // Token sesuai, tidak perlu tindakan tambahan
          print('Token masih valid.');
        }
      } else {
        print('Gagal ambil data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> logout() async {
    // Hapus data dari SharedPreferences
    await clearSharedPreferences();

    // Navigasi ke halaman login
    Get.offAllNamed('/login');
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> keys = prefs.getKeys().toList();

    for (String key in keys) {
      if (key != 'tokenfcm') {
        prefs.remove(key);
      }
    }
  }

  void _showLogoutDialog() {
    // Tampilkan dialog atau notifikasi untuk login ulang
    Get.defaultDialog(
      title: 'Sesi Berakhir',
      middleText:
          'Sesi Anda telah berakhir. Mohon tekan ok untuk login kembali',
      confirm: ElevatedButton(
        onPressed: () {
          // Lakukan logout atau aksi lainnya
          logout();
          Get.offAllNamed('/login');
        },
        child: Text('OK'),
      ),
    );
  }
}

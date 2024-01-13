import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import '../../../data/providers/services.dart';

class NavigationKurirController extends GetxController {
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
    String? id_kurir = prefs.getString('id_kurir');

    try {
      final response = await http.post(
        Uri.parse(Api.getTokenKurir),
        body: {
          'id_kurir': id_kurir, // Ganti dengan informasi unik dari pengguna
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final newToken = jsonResponse['data']['token'];

        // Bandingkan token yang ada dengan newToken
        String? existingToken = prefs.getString('tokenKurir');
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

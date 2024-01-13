import 'dart:convert';
import 'package:dikantin_o_l_d/app/data/models/menu.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/services.dart';

class MenuProvider extends GetxController {
  Future<Menu> loadMenuprovider() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idkantin = prefs.getString('id_kantin');
    print("ini id kantin:$idkantin");
    final Map<String, String> postData = {
      "id_kantin": idkantin.toString(),
    };
    final response = await http.post(
      Uri.parse(Api.menu),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      return Menu.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }

  Future<void> updatehabis(String id) async {
    final url = Uri.parse(Api.updateHabis);
    final response = await http.post(
      url,
      body: {
        "id_menu": id,
      },
    );
    if (response.statusCode == 200) {
      // Berhasil mengubah status penjualan
      print('Berhasil mengubah status menjadi habis');
    } else {
      // Gagal mengubah status penjualan
      print('Gagal mengubah status menjadi habis');
    }
  }

  Future<void> updateAda(String id) async {
    final url = Uri.parse(Api.updateAda);
    final response = await http.post(
      url,
      body: {
        "id_menu": id,
      },
    );
    if (response.statusCode == 200) {
      // Berhasil mengubah status penjualan
      print('Berhasil mengubah status menjadi ada');
    } else {
      // Gagal mengubah status penjualan
      print('Gagal mengubah status menjadi ada');
    }
  }

  Future<void> updateTutup(String id) async {
    final url = Uri.parse(Api.updateTutup);
    final response = await http.post(
      url,
      body: {
        "id_kantin": id,
      },
    );
    if (response.statusCode == 200) {
      // Berhasil mengubah status penjualan
      print('Berhasil mengubah status menjadi habis Semua');
    } else {
      // Gagal mengubah status penjualan
      print('Gagal mengubah status menjadi habis Semua');
    }
  }

  Future<void> updateBuka(String id) async {
    final url = Uri.parse(Api.updateBuka);
    final response = await http.post(
      url,
      body: {
        "id_kantin": id,
      },
    );
    if (response.statusCode == 200) {
      // Berhasil mengubah status penjualan
      print('Berhasil mengubah status menjadi ada Semua');
    } else {
      // Gagal mengubah status penjualan
      print('Gagal mengubah status menjadi ada Semua');
    }
  }
}

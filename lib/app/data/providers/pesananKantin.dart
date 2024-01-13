import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../repository/services.dart';
import '../models/pesanan.dart';

class PesananKantin extends GetxController {
  Future<Test> pesananKantin() async {
    final prefs = await SharedPreferences.getInstance();
    String? idKantin = prefs.getString('id_kantin');
    final response = await http.post(
      Uri.parse(Api.pesananKantin),
      body: {'id_kantin': idKantin?.toString() ?? ''},
    );

    if (response.statusCode == 200) {
      return Test.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat s');
    }
  }

  Future<void> MemasakOnline(String id_kantin, id_menu, kodeTr) async {
    final Map<String, String> postData = {
      "kode": "1",
      "kantin": id_kantin.toString(), // sesuaikan dengan kantin yang login
      "kode_menu": id_menu.toString(),
      "kode_tr": kodeTr.toString(),
    };

    final response = await http.post(
      Uri.parse(Api.konfirmasi),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      // Berhasil membatalkan pesanan
      print('Pesanan berhasil dimasak');
    } else {
      // Gagal membatalkan pesanan
      print('Gagal membatalkan pesanan. Status code: ${response.statusCode}');
      throw Exception('Gagal membatalkan pesanan');
    }
  }

  Future<void> MemasakselesaiOfline(String id_kantin, id_menu, kodeTr) async {
    final Map<String, String> postData = {
      "kode": "6",
      "kantin": id_kantin.toString(), // sesuaikan dengan kantin yang login
      "kode_menu": id_menu.toString(),
      "kode_tr": kodeTr.toString(),
    };

    final response = await http.post(
      Uri.parse(Api.konfirmasi),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      // Berhasil membatalkan pesanan
      print('Pesanan berhasil dimasak');
    } else {
      print('Gagal membatalkan pesanan. Status code: ${response.statusCode}');
      throw Exception('Gagal membatalkan pesanan');
    }
  }

  Future<void> MemasakselesaiOnline(String id_kantin, kodeTr, id_menu) async {
    final Map<String, String> postData = {
      "kode": "2",
      "kantin": id_kantin.toString(),
      "kode_menu": id_menu.toString(),
      "kode_tr": kodeTr.toString(),
    };

    final response = await http.post(
      Uri.parse(Api.konfirmasi),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      // Berhasil membatalkan pesanan
      print('Pesanan berhasil dimasak');
    } else {
      // Gagal membatalkan pesanan
      print('Gagal membatalkan pesanan. Status code: ${response.statusCode}');
      throw Exception('Gagal membatalkan pesanan');
    }
  }
}

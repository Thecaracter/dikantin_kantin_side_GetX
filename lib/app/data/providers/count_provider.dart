import 'dart:convert';
import 'package:dikantin_o_l_d/app/data/models/Count.dart';
import 'package:dikantin_o_l_d/app/repository/services.dart';
import "package:http/http.dart" as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/penghasilan.dart';

class countProvider extends GetxController {
  Future<Count> loadCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final response = await http.get(
      Uri.parse(Api.count),
      headers: {
        'Authorization':
            'Bearer $token', // Gantilah [TOKEN] dengan token yang sesuai
      },
    );

    if (response.statusCode == 200) {
      return Count.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}

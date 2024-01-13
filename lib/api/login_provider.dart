import 'dart:convert';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends GetxController {
  static const String baseUrl = 'http://dikantin.com/api';

  Future<http.Response> loginKantin(
      String email, String password, String fcmToken) async {
    final Map<String, String> requestBody = {
      'email': email,
      'password': password,
      'token_fcm': fcmToken,
    };
    final response = await http.post(Uri.parse('$baseUrl/validate/loginKantin'),
        body: requestBody);
    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonResponse = jsonDecode(response.body);

      // Extract the "token" from the JSON
      final idKantin =
          jsonResponse['data']['id_kantin'].toString(); // Convert to String

      // Save token to SharedPreferences
      saveTokenToSharedPreferencess(idKantin);

      return response;
    } else {
      // Handle errors in login
      final jsonResponse = jsonDecode(response.body);
      final errorMessage = jsonResponse['data'];

      print('${response.body}');

      if (errorMessage == "Email atau password anda salah") {
        Get.snackbar(
          'Gagal Login Email atau password anda salah ..!',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('$errorMessage');
      } else if (errorMessage == "Password salah") {
        Get.snackbar(
          'Gagal Login password salah',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('$errorMessage');
      } else {
        Get.snackbar(
          'Gagal Login !..',
          '$errorMessage',
          snackPosition: SnackPosition.TOP, // Menampilkan Snackbar dari atas
          duration: Duration(seconds: 2),
        );
        throw Exception('$errorMessage');
      }
    }
  }

  Future<String> saveTokenToSharedPreferencess(String idKantin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id_kantin', idKantin);
    return idKantin;
  }
}

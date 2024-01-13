// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:ffi';
import 'package:dikantin_o_l_d/app/repository/services.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends GetxController {
  RxBool isKantinActive = false.obs;

  Future<http.Response> loginKantin(
      String email, String password, String fcmToken) async {
    final Map<String, String> requestBody = {
      'email': email,
      'password': password,
      'token_fcm': fcmToken,
    };
    final response = await http.post(Uri.parse(Api.signIn), body: requestBody);
    if (response.statusCode == 200) {
      // Parse the JSON response
      final jsonResponse = jsonDecode(response.body);

      // Extract the "token" from the JSON
      final idKantin =
          jsonResponse['data']['id_kantin'].toString(); // Convert to String
      final token = jsonResponse['data']['token']; // Convert to String
      final username = jsonResponse['data']['username']; // Convert to String
      final email = jsonResponse['data']['email']; // Convert to String
      final status =
          jsonResponse['data']['kantin']['status'] == 1 ? true : false;

      // Save token to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('status', status);
      await prefs.setString('token', token);
      saveTokenToSharedPreferencess(idKantin, username, email);
      print(email);

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

  Future<void> kantinSwitch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('Token Kantin pada saat logout: $token'); // Tambahkan ini

    final Map<String, String> postData = {};

    final response = await http.post(
      Uri.parse(Api.kantinAktif),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(postData),
    );

    if (response.statusCode == 200) {
      isKantinActive.value = !isKantinActive.value;
      prefs.setBool('status', isKantinActive.value);
      isKantinActive.value = true;
      print('Akun hidup');
    } else {
      isKantinActive.value = false;
      print('Gagal membatalkan pesanan. Status code: ${response.statusCode}');
      throw Exception('Akun eror');
    }
  }

  Future<void> saveTokenToSharedPreferencess(
      String idKantin, String username, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id_kantin', idKantin);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
  }
}

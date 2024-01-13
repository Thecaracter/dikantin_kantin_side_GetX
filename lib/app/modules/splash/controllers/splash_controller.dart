import 'package:dikantin_o_l_d/app/services/notification_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../beranda/controllers/beranda_controller.dart';

class SplashController extends GetxController {
  // final berandaController = Get.put(BerandaController());
  //TODO: Implement SplashController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // TODO: Initialize any other necessary services or variables
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() {}

  @override
  Future<void> onReady() async {
    super.onReady();
    print('SplashController onReady called');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      _navigateToLogin();
    } else {
      _navigateToNavigation();
    }
  }

  void _navigateToLogin() {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed('/login');
    });
  }

  void _navigateToNavigation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future.delayed(Duration(seconds: 3), () {
      if (prefs.getString('token') != null) {
        Get.offAllNamed('/navigation');
        // berandaController.getToken();
      } else {
        _navigateToLogin();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}

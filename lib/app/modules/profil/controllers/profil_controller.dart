import 'package:dikantin_o_l_d/app/data/providers/login_provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilController extends GetxController {
  //TODO: Implement ProfilController

  final count = 0.obs;
  RxString username = ''.obs; // Gunakan RxString
  RxString email = ''.obs; // Gunakan RxString
  // final isSwitchOn = false.obs;
  // final LoginProvider loginProvider = LoginProvider().obs();

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // void toggleSwitch(bool value) {
  //   isSwitchOn.value = value;
  //   loginProvider.kantinSwitch();
  //   if (value) {
  //     Get.snackbar('Akun status', 'ON');
  //   }
  // }

  void increment() => count.value++;
  Future<void> logout() async {
    // Hapus data dari SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    // Navigasi ke halaman login
    Get.offAllNamed('/login');
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username.value = prefs.getString('username') ?? ''; // Set nilai RxString
    email.value = prefs.getString('email') ?? ''; // Set nilai RxString
    update(); // Perbarui state setelah mendapatkan nilai baru
  }
}

// ignore_for_file: unused_local_variable

import 'package:dikantin_o_l_d/app/data/models/Count.dart';
import 'package:dikantin_o_l_d/app/data/models/penghasilan.dart';
import 'package:dikantin_o_l_d/app/data/providers/count_provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/providers/login_provider.dart';
import '../../../data/providers/menu_provider.dart';
import '../../../data/providers/penghasilan_provider.dart';
import '../../menuNav/controllers/menu_nav_controller.dart';

class BerandaController extends GetxController {
  //TODO: Implement BerandaController
  final penghasilanProvider = PenghasilanProvider().obs;
  final cProvider = countProvider().obs;
  final isLoading = false.obs; // Tambahkan isLoading
  final menuNavController = Get.put(MenuNavController());
  final Rx<Penghasilan> penghasilan = Rx<Penghasilan>(Penghasilan());
  final Rx<Count> dilayani = Rx<Count>(Count());

  RxString kantin = ''.obs; // Gunakan RxString
  final isSwitchOn = false.obs;
  final menuProvider = MenuProvider().obs;
  final LoginProvider loginProvider = LoginProvider().obs();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getToken();
    loadData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> loadData() async {
    await loadPenghasilanbulanan();
    await loadDilayaniSelesai();
  }

  void toggleSwitch(bool value) {
    isSwitchOn.value = value;
    loginProvider.kantinSwitch();
    if (value) {
      updateBuka(kantin.value);
      Get.snackbar('Akun status', 'ON');
    } else {
      updateTutup(kantin.value);
    }
  }

  Future<void> updateTutup(String id) async {
    try {
      isLoading(true);
      await menuProvider.value.updateTutup(id);
      await menuNavController.loadmenu();
      update();
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error saat update habis: $error');
    }
  }

  Future<void> updateBuka(String id) async {
    try {
      isLoading(true);
      await menuProvider.value.updateBuka(id);
      await menuNavController.loadmenu();
      update();
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error saat update habis: $error');
    }
    await loadPenghasilanbulanan();
    await loadDilayaniSelesai();
  }

  Future<void> loadPenghasilanbulanan() async {
    try {
      isLoading(true);
      Penghasilan result = await penghasilanProvider.value.loadPenghasilan();
      penghasilan(result);
      isLoading(false);
      update();
      print('Ini load penghasilan dipanggil');
    } catch (error) {
      isLoading(false);
      print('Error fetching datad: $error');
    }
  }

  Future<void> loadDilayaniSelesai() async {
    try {
      isLoading(true);
      Count result = await cProvider.value.loadCount();
      dilayani(result);
      isLoading(false);
      update();
      print('Ini load dilayani dipanggil');
    } catch (error) {
      isLoading(false);
      print('Error fetching loadDilayaniSelesai: $error');
    }
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    kantin.value = prefs.getString('id_kantin') ?? ''; // Set nilai RxString
    // bool status = prefs.getBool('status') ?? false;
    // isSwitchOn.value = status;
    Count result = await cProvider.value.loadCount();
    print('-------');
    print(result.data?.statusKantin);
    bool status = result.data?.statusKantin == 1 ? true : false;
    isSwitchOn.value = status;
    String token = prefs.getString('token') ?? '';
    // print(status);
    update(); // Perbarui state setelah mendapatkan nilai baru
  }
}

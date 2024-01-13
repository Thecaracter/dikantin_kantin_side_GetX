import 'package:dikantin_o_l_d/app/data/providers/pesananKantin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/pesanan.dart';

class PesananController extends GetxController {
  final isLoading = false.obs; // Tambahkan isLoading
  final pesanankantinMemasakOnline = PesananKantin().obs;
  final pesanankantinMemasakselesaiOffline = PesananKantin().obs;
  final pesanankantinMemasakselesaiOnline = PesananKantin().obs;
  final pesananMemasakOnline = <Data>[].obs;
  final pesananMemasakselesaiOffline = <Data>[].obs;
  final pesananMemasakselesaiOnline = <Data>[].obs;
  //TODO: Implement PesananController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadPesananKantin();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> loadPesananKantin() async {
    try {
      isLoading(true);
      final result = await pesanankantinMemasakOnline.value.pesananKantin();
      pesananMemasakOnline.assignAll(result.data ?? []);
      isLoading(false);
      print("object");
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> keMemasakOnline(String id_kantin, id_menu, kodeTr) async {
    try {
      isLoading(true);
      await pesanankantinMemasakOnline.value
          .MemasakOnline(id_kantin, id_menu, kodeTr);
      update();
      isLoading(false);
      Get.snackbar(
        'Sukses',
        'Pesanan telah dimasak',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } catch (error) {
      isLoading(false);
      print('Error saat membatalkan memasak online: $error');
    }
  }

  Future<void> keMemasakselesaiOffline(
      String id_kantin, id_menu, kodeTr) async {
    try {
      isLoading(true);
      await pesanankantinMemasakselesaiOffline.value
          .MemasakselesaiOfline(id_kantin, id_menu, kodeTr);
      // Refresh data setelah pembatalan pesanan berhasil
      await loadPesananKantin();
      update();
      Get.snackbar(
        'Sukses',
        'Pesanan telah selesai offline',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error saat membatalkan selesai offline: $error');
    }
  }

  Future<void> keMemasakselesaiOnline(String id_kantin, id_menu, kodeTr) async {
    try {
      isLoading(true);
      pesanankantinMemasakselesaiOnline.value
          .MemasakselesaiOnline(id_kantin, kodeTr, id_menu);
      // Refresh data setelah pembatalan pesanan berhasil
      await loadPesananKantin();
      update();
      isLoading(false);
      Get.snackbar(
        'Sukses',
        'Pesanan telah selesai online',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
    } catch (error) {
      isLoading(false);
      print('Error saat membatalkan selesai online: $error');
    }
  }
}

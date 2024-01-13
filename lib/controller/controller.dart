import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/pesananProvider.dart';
import '../model/pesananModel.dart';

class pesananKantin extends GetxController {
  final isLoading = false.obs; // Tambahkan isLoading
  final pesanankantinMemasakOnline = PesananKantin().obs;
  final pesanankantinMemasakselesaiOffline = PesananKantin().obs;
  final pesanankantinMemasakselesaiOnline = PesananKantin().obs;
  final pesananMemasakOnline = <Data>[].obs;
  final pesananMemasakselesaiOffline = <Data>[].obs;
  final pesananMemasakselesaiOnline = <Data>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadPesananKantin();
  }

  Future<void> loadPesananKantin() async {
    try {
      isLoading(true);
      final result = await pesanankantinMemasakOnline.value.pesananKantin();
      pesananMemasakOnline.assignAll(result.data ?? []);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }
  // Future<void> loadSelesai() async {
  //   try {
  //     isLoading(true);
  //     final result = await pesanankantinMemasakOnline.value.loadStatusSucces();
  //     pesananMemasakOnline.assignAll(result.data ?? []);
  //     isLoading(false);
  //   } catch (error) {
  //     isLoading(false);
  //     print('Error fetching data: $error');
  //   }
  // }
  // Future<void> loadDilayani() async {
  //   try {
  //     isLoading(true);
  //     final result = await pesanankantinMemasakOnline.value.loadStatusDilayani();
  //     pesananMemasakOnline.assignAll(result.data ?? []);
  //     isLoading(false);
  //   } catch (error) {
  //     isLoading(false);
  //     print('Error fetching data: $error');
  //   }
  // }

  Future<void> keMemasakOnline(String id_kantin, id_menu, kodeTr) async {
    try {
      isLoading(true);
      await pesanankantinMemasakOnline.value
          .MemasakOnline(id_kantin, id_menu, kodeTr);
      // Refresh data setelah pembatalan pesanan berhasil
      await loadPesananKantin();
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
      await pesanankantinMemasakselesaiOnline.value
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

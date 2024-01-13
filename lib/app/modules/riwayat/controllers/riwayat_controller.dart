import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../rekapHarian/controllers/rekap_harian_controller.dart';
import '../../rekapHarianproduk/controllers/rekap_harianproduk_controller.dart';

class RiwayatController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement RiwayatController
  final RekapHarianprodukController rekapHarianProdukController =
      Get.put(RekapHarianprodukController());
  final RekapHarianController rekapHarianController =
      Get.put(RekapHarianController());
  late AnimationController _controller;
  late TabController tabController; // Tambahkan variabel TabController
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(_handleTabSelection);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _controller.dispose();
    tabController.dispose(); // Hapus TabController saat controller ditutup
  }

  void increment() => count.value++;
  void _handleTabSelection() async {
    // Handle perubahan tab di sini
    switch (tabController.index) {
      case 1:
        rekapHarianController.loadRekapHarianAll();
        break;
      case 2:
        rekapHarianProdukController.loadHarianProdukAll();

        break;
    }
  }

  void startAnimation() {
    _controller.forward();
  }
}

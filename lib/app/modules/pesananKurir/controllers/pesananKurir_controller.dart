import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../data/models/pesanan_kirim_model.dart';
import '../../../data/providers/pesanan_provider.dart';

class PesananKurirController extends GetxController
    with GetTickerProviderStateMixin {
  //TODO: Implement PesananController
  late AnimationController _controller;
  late TabController tabController; // Tambahkan variabel TabController
  final count = 0.obs;
  final isLoading = true.obs; // Define RxBool for loading state
  final pesananProvider = PesananProvider().obs; // Instantiate your provider
  late PesananKirim pesananUntukDikirim = PesananKirim();
  late PesananKirim pesananKonfirmasi = PesananKirim();
  late PesananKirim loadRiwayat = PesananKirim();
  var orderUntukDikirim = <DataPesananKirim>[].obs;
  var orderKonfirmasi = <DataPesananKirim>[].obs;
  var riwayatKurir = <DataPesananKirim>[].obs;
  String scannedQrCode = '';

  @override
  void onInit() {
    super.onInit();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_handleTabSelection);

    loadUntukDikirim();
    loadKonfirmasi();
    loadRiwayatKurir();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _controller.dispose();
    tabController.dispose(); // Hapus TabController saat controller ditutup

    super.onClose();
  }

  void _handleTabSelection() async {
    // Handle perubahan tab di sini
    switch (tabController.index) {
      case 0:
        loadUntukDikirim();
        break;
      case 1:
        loadKonfirmasi();
        break;
    }
  }

  void increment() => count.value++;
  void startAnimation() {
    _controller.forward();
  }

  DataPesananKirim? findOrderById(String orderId) {
    // Cari pesanan di setiap kategori (proses, dikirim, diterima)

    final orderDikirimById = orderUntukDikirim
        .firstWhereOrNull((order) => order.transaksi?.kodeTr == orderId);
    if (orderDikirimById != null) {
      return orderDikirimById;
    }

    final orderDiterimaById = orderKonfirmasi
        .firstWhereOrNull((order) => order.transaksi?.kodeTr == orderId);
    if (orderDiterimaById != null) {
      return orderDiterimaById;
    }

    return null; // Return null jika pesanan tidak ditemukan
  }

  Future<void> scanQrCode(String kode_tr) async {
    try {
      // Panggil fungsi scan QR code dari paket barcode_scanner
      scannedQrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (kode_tr != scannedQrCode) {
        Get.snackbar("Scan Gagal, ", "Kode Tidak Sesuai",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 5),
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }

      if (scannedQrCode == kode_tr) {
        Get.snackbar("Scan Berhasil, ", "Menunggu Konfirmasi Admin",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 5),
            backgroundColor: Colors.green,
            colorText: Colors.white);
        await confirmKurir(kode_tr, scannedQrCode);
      }
      // Update nilai hasil scan ke dalam variabel scannedQrCode
      // scannedQrCode.value = result ?? '';
    } catch (e) {
      // Tangani error jika terjadi
      print('Error during QR code scanning: $e');
    }
  }

  Future<void> refreshPesanan() async {
    await loadUntukDikirim();
    await loadKonfirmasi();
  }

  Future<void> loadUntukDikirim() async {
    try {
      isLoading(true);
      final result = await pesananProvider.value.untukDikirim();
      pesananUntukDikirim = result;
      orderUntukDikirim.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> loadKonfirmasi() async {
    try {
      isLoading(true);
      final result = await pesananProvider.value.konfirmasi();
      pesananKonfirmasi = result;
      orderKonfirmasi.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> loadRiwayatKurir() async {
    try {
      isLoading(true);
      final result = await pesananProvider.value.riwayatKurir();
      loadRiwayat = result;
      riwayatKurir.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> acceptedPesanan(String kodeTr) async {
    try {
      isLoading(true);
      await pesananProvider.value.acceptPesanan(kodeTr);
      // Refresh data setelah pembatalan pesanan berhasil
      await loadUntukDikirim();
      update();

      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error saat membatalkan pesanan: $error');
    }
  }

  Future<void> confirmKurir(String kodeTr, String bukti) async {
    try {
      isLoading(true);
      await pesananProvider.value.konfirKurir(kodeTr, bukti);
      // Refresh data setelah pembatalan pesanan berhasil
      await loadKonfirmasi();
      update();

      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error saat membatalkan pesanan: $error');
    }
  }
}

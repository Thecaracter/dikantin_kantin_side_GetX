import 'package:dikantin/app/data/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OtpPageController extends GetxController {
  //TODO: Implement OtpPageController
  final VerificationProvider _verificationProvider = VerificationProvider();

  RxBool isLoading = false.obs;
  final count = 0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
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
  Future<void> verifyCode(String kode) async {
    try {
      isLoading(true);

      final result = await _verificationProvider.verifyCode(kode);

      if (result) {
        showVerificationSuccessDialog();

        // print('Verification successful');
      } else {
        Get.snackbar(
          'Gagal',
          'Kode salah mohon cek kembali',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
        );
      }
    } finally {
      isLoading(false);
    }
  }

  void showVerificationSuccessDialog() {
    Get.defaultDialog(
      title: "Verification Successful",
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            "assets/checklist.json", // Ganti dengan nama file Lottie Anda
            width: 150.0,
            height: 150.0,
            fit: BoxFit.cover,
          ),
        ],
      ),
      barrierDismissible:
          false, // Tidak dapat dihapus dengan mengklik di luar dialog

      actions: [
        ElevatedButton(
          onPressed: () {
            Get.offAllNamed("/ubah-password");
          },
          child: Text('Lanjutkan'),
        ),
      ],
    );
  }
}

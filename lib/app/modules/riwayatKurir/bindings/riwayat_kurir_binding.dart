import 'package:get/get.dart';

import '../controllers/riwayat_kurir_controller.dart';

class RiwayatKurirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RiwayatKurirController>(
      () => RiwayatKurirController(),
    );
  }
}

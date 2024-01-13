import 'package:get/get.dart';

import '../controllers/rekap_harianproduk_controller.dart';

class RekapHarianprodukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RekapHarianprodukController>(
      () => RekapHarianprodukController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/rekap_harian_controller.dart';

class RekapHarianBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RekapHarianController>(
      () => RekapHarianController(),
    );
  }
}

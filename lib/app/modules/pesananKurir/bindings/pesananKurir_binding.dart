import 'package:get/get.dart';

import '../controllers/pesananKurir_controller.dart';

class PesananKurirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PesananKurirController>(
      () => PesananKurirController(),
    );
  }
}

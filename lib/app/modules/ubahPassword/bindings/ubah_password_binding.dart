import 'package:get/get.dart';

import '../controllers/ubah_password_controller.dart';

class UbahPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahPasswordController>(
      () => UbahPasswordController(),
    );
  }
}

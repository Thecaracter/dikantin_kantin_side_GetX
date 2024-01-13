import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileKurirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileKurirController>(
      () => ProfileKurirController(),
    );
  }
}

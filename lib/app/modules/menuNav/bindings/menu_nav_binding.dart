import 'package:get/get.dart';

import '../controllers/menu_nav_controller.dart';

class MenuNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuNavController>(
      () => MenuNavController(),
    );
  }
}

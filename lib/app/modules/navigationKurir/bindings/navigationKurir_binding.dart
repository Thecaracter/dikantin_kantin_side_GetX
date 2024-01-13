import 'package:get/get.dart';

import '../controllers/navigationKurir_controller.dart';

class NavigationKurirBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationKurirController>(
      () => NavigationKurirController(),
    );
  }
}

import 'package:get/get.dart';

import '../controllers/detail_transaksi_controller.dart';

class DetailTransaksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTransaksiController>(
      () => DetailTransaksiController(),
    );
  }
}

import 'dart:convert';

import 'package:dikantin_o_l_d/app/data/riwayat_provider.dart';
import 'package:dikantin_o_l_d/app/data/models/riwayat.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaporanController extends GetxController {
  //TODO: Implement LaporanController

  var riwayatProvider = RiwayatProvider().obs;
  final count = 0.obs;
  var date = "semua".obs;
  var total = "Rp.0".obs;
  var isSemua = true.obs;

  // Nullable observable variables to store Riwayat
  Rxn<DateTime>? dateNow;
  Rxn<DateTime>? dateTo;

  // Observable variable to store Riwayat
  var riwayatData = Rxn<RiwayatLaporan>();

  LaporanController() {
    // Initialize dateNow and dateTo to null
    dateNow = Rxn<DateTime>();
    dateTo = Rxn<DateTime>();
  }

  @override
  void onInit() async {
    super.onInit();
    print("on init riwayat");

    // Listen for changes to dateNow and dateTo and call fetchRiwayat
    ever(dateNow!, (_) {
      fetchRiwayat();
    });

    ever(dateTo!, (_) {
      fetchRiwayat();
    });

    await fetchRiwayat(); // Await for the initial fetchRiwayat to complete
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

  Future<void> fetchRiwayat() async {
    print("jalan ni fungsi");
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (isSemua.value) {
      dateNow = null;
      dateTo = null;
      date.value = "semua";
    }
    if (token != null) {
      var response = await riwayatProvider.value.fetchDataRiwayat(
        token: token,
        dateStart: dateNow?.value?.toLocal().toString().split(' ')[0],
        dateEnd: dateTo?.value?.toLocal().toString().split(' ')[0],
      );
      print(response);
      // Parse and store Riwayat in the observable variable
      riwayatData.value = RiwayatLaporan.fromJson(jsonDecode(response.body));
      print(riwayatData.value);
    } else {
      Get.snackbar('Error', 'Terjadi kesalahan session. Silahkan login ulang.');
    }
  }

  void setDateFrom(value) {
    print("set from");
    dateNow = Rxn<DateTime>();

    dateNow!.value = value;
  }

  void setDateTo(value) {
    print("set to");
    dateTo = Rxn<DateTime>();
    dateTo!.value = value;
  }
}

import 'package:dikantin_o_l_d/app/data/providers/rekapHarianPerproduk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_custom.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/rekapHarianProduk.dart';
import '../../../data/providers/rhp_provider.dart';

import '../../../data/models/rekapHarianProduk.dart';
import '../../../data/providers/rhp_provider.dart';

class RekapHarianprodukController extends GetxController {
  final isLoading = false.obs; // Tambahkan isLoading
  final dataRekapPendapatanHarain = RekapHarianProduk().obs;
  final rekapProvider = RekapHarianProdukProv().obs;
  late RekapharianProduk rekapPendapatanharian = RekapharianProduk();
  var rekapData = <Data>[].obs;
  var dateRange = DateTimeRange(
          start: DateTime.now(),
          end: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 6))
      .obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();

    refreshData();
    loadHarianProdukAll();
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

  Future<void> refreshData() async {
    await searchHarianProduk('', '');
  }

  chooseDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
        context: Get.context!,
        firstDate: DateTime(DateTime.now().year - 20),
        lastDate: DateTime(DateTime.now().year + 20),
        initialDateRange: dateRange.value);
    if (picked != null && picked != dateRange.value) {
      dateRange.value = picked;
      searchHarianProduk(picked.start.toString(), picked.end.toString());
    }
  }

  Future<void> loadHarianProdukAll() async {
    try {
      isLoading(true);
      final result = await rekapProvider.value.loadDataRHPall();
      rekapPendapatanharian = result;
      rekapData.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> searchHarianProduk(String searchFrom, String searchTo) async {
    try {
      isLoading(true);
      final result =
          await rekapProvider.value.loadDataRHP(searchFrom, searchTo);
      rekapPendapatanharian = result;
      rekapData.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }
}

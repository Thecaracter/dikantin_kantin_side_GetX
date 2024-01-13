import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/RekapHarian.dart';
import '../../../data/providers/rph_provider.dart';

class RekapHarianController extends GetxController {
  //TODO: Implement RekapHarianController
  final isLoading = false.obs; // Tambahkan isLoading
  final rekapProvider = RekapPendapatanHarian().obs;
  late RekapPendapatanharian rekapPendapatanharian = RekapPendapatanharian();
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
    loadRekapHarian();
    refreshData();
    loadRekapHarianAll();
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

  Future<void> loadRekapHarian() async {
    try {
      isLoading(true);
      final result = await rekapProvider.value.loadDataRPHall();
      rekapPendapatanharian = result;
      rekapData.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> refreshData() async {
    await searchRekapHarian('', '');
  }

  chooseDateRange() async {
    DateTimeRange? picked = await showDateRangePicker(
        context: Get.context!,
        firstDate: DateTime(DateTime.now().year - 20),
        lastDate: DateTime(DateTime.now().year + 20),
        initialDateRange: dateRange.value);
    if (picked != null && picked != dateRange.value) {
      dateRange.value = picked;
      searchRekapHarian(picked.start.toString(), picked.end.toString());
    }
  }

  Future<void> loadRekapHarianAll() async {
    try {
      isLoading(true);
      final result = await rekapProvider.value.loadDataRPHall();
      rekapPendapatanharian = result;
      rekapData.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> searchRekapHarian(String searchFrom, String searchTo) async {
    try {
      isLoading(true);
      final result =
          await rekapProvider.value.loadDataRPH(searchFrom, searchTo);
      rekapPendapatanharian = result;
      rekapData.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }
}

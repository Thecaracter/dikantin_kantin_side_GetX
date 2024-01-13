import 'package:dikantin_o_l_d/app/data/providers/menu_provider.dart';
import 'package:get/get.dart';

import '../../../data/models/menu.dart';

class MenuNavController extends GetxController {
  //TODO: Implement MenuNavController
  final isLoading = false.obs; // Tambahkan isLoading
  final menuProvider = MenuProvider().obs;
  late Menu menuData = Menu();
  var dataMenu = <DataMenu>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    loadmenu();
  }

  @override
  void onReady() {
    super.onReady();
    loadmenu();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setLoading(bool value) {
    isLoading.value = value; // Metode untuk mengatur status isLoading
  }

  void increment() => count.value++;

  Future<void> loadmenu() async {
    try {
      isLoading(true);
      final result = await menuProvider.value.loadMenuprovider();
      menuData = result;
      dataMenu.assignAll(result.data!);
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error fetching data: $error');
    }
  }

  Future<void> menuHabis(String id) async {
    try {
      isLoading(true);
      await menuProvider.value.updatehabis(id);
      await loadmenu();
      update();
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error saat update habis: $error');
    }
  }

  Future<void> menuAda(String id) async {
    try {
      isLoading(true);
      await menuProvider.value.updateAda(id);
      await loadmenu();
      update();
      isLoading(false);
    } catch (error) {
      isLoading(false);
      print('Error saat update habis: $error');
    }
  }
}

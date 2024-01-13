import 'package:carbon_icons/carbon_icons.dart';
import 'package:dikantin_o_l_d/app/modules/beranda/views/beranda_view.dart';
import 'package:dikantin_o_l_d/app/modules/menuNav/views/menu_nav_view.dart';
import 'package:dikantin_o_l_d/app/modules/pesanan/controllers/pesanan_controller.dart';
import 'package:dikantin_o_l_d/app/modules/pesanan/views/pesanan_view.dart';
import 'package:dikantin_o_l_d/app/modules/profil/views/profil_view.dart';
import 'package:dikantin_o_l_d/app/modules/riwayat/views/riwayat_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../beranda/controllers/beranda_controller.dart';
import '../../menuNav/controllers/menu_nav_controller.dart';
import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  NavigationView({Key? key}) : super(key: key);

  final BerandaController berandaController = Get.put(BerandaController());
  final MenuNavController menuNavController = Get.put(MenuNavController());
  final PesananController pesananController = Get.put(PesananController());
  final NavigationController navigationController =
      Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    print('textscalefactor: ${query.textScaleFactor}');
    print('devicePixelRatio: ${query.devicePixelRatio}');
    DateTime? currentBackPressTime;

    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 1)) {
        currentBackPressTime = now;
        ScaffoldMessenger.of(context).showSnackBar(
          // Perubahan di sini
          SnackBar(
            content: Text('Tekan sekali lagi untuk keluar'),
          ),
        );
        return Future.value(false);
      }
      return Future.value(true);
    }

    return MediaQuery(
      data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15)),
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Obx(
          () => Scaffold(
            backgroundColor: Colors.white, // Atur warna latar belakang Scaffold
            body: _buildBody(navigationController.currentTab.value),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await pesananController.loadPesananKantin();
                await navigationController.checkToken();

                navigationController.changeTab(2);

                // Do other actions if needed
              },
              backgroundColor: navigationController.currentTab.value == 2
                  ? Color(0xffe4ea17)
                  : Color(0xff3ca2d9),
              child: Icon(
                CarbonIcons.catalog,
                size: 24.0,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: _buildBottomAppBar(),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(int currentTab) {
    Widget selectedWidget;

    switch (currentTab) {
      case 0:
        selectedWidget = BerandaView();
      case 1:
        selectedWidget = MenuNavView();
      case 2:
        selectedWidget = PesananView();
      case 3:
        selectedWidget = RiwayatView();
      case 4:
        selectedWidget = ProfilView();
      default:
        selectedWidget = BerandaView();
    }
    return selectedWidget;
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10,
      color: Color(0xff3ca2d9),
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildTabButton(0, Icons.home, 'Beranda'),
            _buildTabButton(1, CarbonIcons.report, 'Menu'),
            SizedBox(width: 40),
            _buildTabButton(3, CarbonIcons.recently_viewed, 'Riwayat'),
            _buildTabButton(4, Icons.account_circle, 'Profil'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int tabIndex, IconData icon, String label) {
    return Obx(
      () => MaterialButton(
        minWidth: 40,
        onPressed: () {
          navigationController.changeTab(tabIndex);
          if (tabIndex == 0) {
            berandaController.loadPenghasilanbulanan();
            berandaController.loadDilayaniSelesai();
            navigationController.checkToken();
          } else if (tabIndex == 1) {
            menuNavController.loadmenu();
            navigationController.checkToken();
          } else if (tabIndex == 3) {
            navigationController.checkToken();
          } else if (tabIndex == 4) {
            navigationController.checkToken();
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: navigationController.currentTab.value == tabIndex
                  ? Color(0xffe4ea17)
                  : Color(0xff87c6e7),
            ),
            Text(
              label,
              style: TextStyle(
                color: navigationController.currentTab.value == tabIndex
                    ? Color(0xffe4ea17)
                    : Color(0xff87c6e7),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dikantin/page/beranda.dart';
import 'package:dikantin/page/menu.dart';
import 'package:dikantin/page/pesan.dart';

import 'package:dikantin/page/profile.dart';
import 'package:dikantin/page/riwayat.dart';
import 'package:get/get.dart';

import 'controller/controller.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
      final pesananKantin pesananController = Get.put(pesananKantin());

  int currentTab = 0;

  final List<Widget> screens = [
    Beranda(),
    Menu(),
    Pesan(),
    Profile(),
    Riwayat()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Beranda();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentScreen = Pesan();
            currentTab = 3;
            pesananController.loadPesananKantin();
          });
        },
        backgroundColor:
            currentTab == 3 ? Color(0xffe4ea17) : Color(0xff3ca2d9),
        child: Icon(
          CarbonIcons.catalog,
          size: 24.0,
          color: currentTab == 3 ? Color(0xff3ca2d9) : Color(0xff87c6e7),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        color: Color(0xff3ca2d9),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Beranda();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CarbonIcons.home,
                          color: currentTab == 0
                              ? Color(0xffe4ea17)
                              : Color(0xff87c6e7),
                        ),
                        Text(
                          'Beranda',
                          style: TextStyle(
                            color: currentTab == 0
                                ? Color(0xffe4ea17)
                                : Color(0xff87c6e7),
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Menu();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CarbonIcons.report,
                          color: currentTab == 1
                              ? Color(0xffe4ea17)
                              : Color(0xff87c6e7),
                        ),
                        Text(
                          'Menu',
                          style: TextStyle(
                            color: currentTab == 1
                                ? Color(0xffe4ea17)
                                : Color(0xff87c6e7),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              //Right tab Bar
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Riwayat();
                        currentTab = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CarbonIcons.recently_viewed,
                          color: currentTab == 4
                              ? Color(0xffe4ea17)
                              : Color(0xff87c6e7),
                        ),
                        Text(
                          'Riwayat',
                          style: TextStyle(
                            color: currentTab == 4
                                ? Color(0xffe4ea17)
                                : Color(0xff87c6e7),
                          ),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
                        currentTab = 5;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CarbonIcons.user_avatar,
                          color: currentTab == 5
                              ? Color(0xffe4ea17)
                              : Color(0xff87c6e7),
                        ),
                        Text(
                          'Profil',
                          style: TextStyle(
                            color: currentTab == 5
                                ? Color(0xffe4ea17)
                                : Color(0xff87c6e7),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

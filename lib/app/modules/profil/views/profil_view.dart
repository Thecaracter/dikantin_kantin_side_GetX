import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../menuNav/controllers/menu_nav_controller.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  ProfilView({Key? key}) : super(key: key);
  final ProfilController profilController = Get.put(ProfilController());
  final MenuNavController menuNavController = Get.find<MenuNavController>();

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    print('textscalefactor: ${query.textScaleFactor}');
    print('devicePixelRatio: ${query.devicePixelRatio}');
    return MediaQuery(
      data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Group_14.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: MediaQuery.of(context).size.width / 500,
                right: MediaQuery.of(context).size.width / 500,
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                        child: Text("PROFIL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(60.0),
                        border: Border.all(width: 2.0, color: Colors.blue),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => Text(
                        profilController.username.toString() ?? '',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffedf4f6),
                          ),
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        profilController.email.toString() ?? '',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffedf4f6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.4),
                    height: MediaQuery.of(context).size.height / 1.7,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffedf3f6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          offset: Offset(4, 4),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return MediaQuery(
                                    data: query.copyWith(
                                        textScaleFactor: query.textScaleFactor
                                            .clamp(1.0, 1.15)),
                                    child: AlertDialog(
                                      content: Image.asset(
                                        "assets/Tanya.png",
                                        width: 64.0,
                                        height: 64.0,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      actions: <Widget>[
                                        Center(
                                          child: Text(
                                            "Anda Akan Logout ?",
                                            style: TextStyle(
                                              color: Color(0xff3CA2D9),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: ElevatedButton(
                                                child: Text('Ya'),
                                                onPressed: () async {
                                                  await profilController
                                                      .logout();
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  backgroundColor: Colors.green,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: ElevatedButton(
                                                child: Text('Tidak'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 55,
                              width: 295,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(4, 4),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: Colors.white,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 2.0),
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    CarbonIcons.logout,
                                    color: Colors.red,
                                  ),
                                ),
                                title: Container(
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.red),
                                  ),
                                ),
                                trailing: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    // color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / 2.7,
                left: MediaQuery.of(context).size.width / 500,
                right: MediaQuery.of(context).size.width / 500,
                child: Column(
                  children: [
                    Container(
                      height: 90,
                      width: 260,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(60.0),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x3f000000),
                            offset: Offset(4, 4),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/Vector.png",
                                  height: 50,
                                  width: 100,
                                ),
                                Text(
                                  "Total Menu",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            width: 1,
                            thickness: 1,
                            color: Color(0xff514D4E),
                          ),
                          Container(
                            child: Text(
                              (menuNavController.dataMenu.length ?? 0)
                                  .toString(),
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

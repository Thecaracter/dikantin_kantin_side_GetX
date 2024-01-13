import 'package:dikantin_o_l_d/app/repository/formatRupiah.dart';
import 'package:dikantin_o_l_d/app/repository/services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/menu_nav_controller.dart';

class MenuNavView extends GetView<MenuNavController> {
  MenuNavView({Key? key}) : super(key: key);
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
        appBar: AppBar(
          backgroundColor: null, // remove background color
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff87c6e7),
                  Colors.blue,
                ],
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  // color: Color(0xffedf3f6),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Image.asset(
                  "assets/logo_baru.png",
                  width: 20.0,
                  height: 20.0,
                ),
              ),
              SizedBox(width: 5),
              Text(
                'MENU',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async => await menuNavController.loadmenu(),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 10),
                    child: Text(
                      "Untuk mengganti ketersediaan menu, silahkan klik tombol Tersedia atau Habis",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff514D4E),
                        ),
                      ),
                    ),
                  )),
                  content(context),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    final baseColorHex = 0xFFE0E0E0;
    final highlightColorHex = 0xFFC0C0C0;
    final mediaHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Obx(() {
      if (menuNavController.isLoading.value) {
        return Shimmer.fromColors(
          baseColor: Color(baseColorHex),
          highlightColor: Color(highlightColorHex),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: mediaHeight,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: mediaHeight * 0.25,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        );
      } else if (menuNavController.menuData.data?.isEmpty ?? true) {
        return Container(
            height: mediaHeight * 0.25,
            child: Center(
              child:
                  Lottie.asset('assets/animation_lokcom8c.json', repeat: false),
            ));
      } else {
        return ListView.builder(
          itemCount: menuNavController.menuData.data!.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final menuDatas = menuNavController.menuData.data![index];
            final hargaPokok = menuDatas.hargaPokok ?? 0;
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Sesuaikan dengan radius yang diinginkan
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      Api.gambar + menuDatas.foto.toString()),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  menuDatas.nama ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(hargaPokok.toRupiah(),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.red,
                                        )),
                                    menuDatas.statusStok.toString() == 'ada'
                                        ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0xFF2579FD),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed: () async {
                                              menuNavController.menuHabis(
                                                  menuDatas.idMenu.toString());
                                            },
                                            child: Text(
                                              "Tersedia",
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(
                                                  255, 253, 37, 37),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed: () {
                                              menuNavController.menuAda(
                                                  menuDatas.idMenu.toString());
                                            },
                                            child: Text(
                                              "Habis",
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
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
          },
        );
      }
    });
  }
}

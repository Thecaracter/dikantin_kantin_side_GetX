// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../repository/services.dart';
import '../controllers/pesanan_controller.dart';

class PesananView extends GetView<PesananController> {
  PesananView({Key? key}) : super(key: key);
  final PesananController pesananController = Get.find<PesananController>();

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    print('textscalefactor: ${query.textScaleFactor}');
    print('devicePixelRatio: ${query.devicePixelRatio}');
    initializeDateFormatting("id_ID");
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
                'PESANAN',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 150,
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async => await pesananController.loadPesananKantin(),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 20, bottom: 10),
                      child: Text(
                        'Tekan tombol "Memasak" untuk memasak pesanan, lalu tekan tombol "Selesai" jika sudah menyelesaikan pesanan',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff514D4E),
                          ),
                        ),
                      ),
                    )),
                    listItems(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listItems(BuildContext context) {
    final baseColorHex = 0xFFE0E0E0;
    final highlightColorHex = 0xFFC0C0C0;
    final query = MediaQuery.of(context);

    final mediaHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Obx(() {
      if (pesananController.isLoading.value) {
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
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        );
      } else if (pesananController.pesananMemasakOnline.isEmpty ?? true) {
        return Container(
            height: mediaHeight * 0.25,
            child: Center(
              child:
                  Lottie.asset('assets/animation_lokcom8c.json', repeat: false),
            ));
      } else {
        return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: pesananController.pesananMemasakOnline.length,
            itemBuilder: (context, index) {
              final menuData = pesananController.pesananMemasakOnline[index];
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 7),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3f000000),
                              offset: Offset(
                                0,
                                2,
                              ),
                              blurRadius: 5,
                            ),
                          ],
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(Api.gambar +
                                              menuData.foto.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Kode Transaksi : " +
                                                menuData.kodeTr.toString(),
                                            style: TextStyle(
                                                color: Color(0xff514d4e),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                menuData.pesanan.toString(),
                                              ),
                                              flex: 3,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "x " +
                                                    menuData.jumlah.toString(),
                                              ),
                                              flex: 1,
                                            ),
                                            menuData.noMeja.toString() == "0"
                                                ? Expanded(
                                                    child: Text(
                                                      "Pesanan Online",
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff514d4e),
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    flex: 1,
                                                  )
                                                : Expanded(
                                                    child: Text(
                                                      "Meja: " +
                                                          menuData.noMeja
                                                              .toString(),
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff514d4e),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    flex: 1,
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Pembeli : " + menuData.pembeli.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xff514d4e),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              menuData.catatan == '' || menuData.catatan == null
                                  ? Text("")
                                  : Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Catatan : " + (menuData.catatan ?? ''),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xff514d4e),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  menuData.statusDetail
                                              .toString()
                                              .contains("selesai") &&
                                          menuData.noMeja
                                              .toString()
                                              .contains("0")
                                      ? Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            'Menunggu Kurir',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 24, 24),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          ),
                                        )
                                      : menuData.statusDetail
                                                  .toString()
                                                  .contains("selesai") &&
                                              menuData.noMeja! > 0
                                          ? Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                'Menunggu pesanan lain selesai',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 255, 24, 24),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12),
                                              ),
                                            )
                                          : SizedBox(),
                                  menuData.statusDetail == null
                                      ? ElevatedButton(
                                          //offline
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color.fromARGB(
                                                255, 154, 154, 154),
                                          ),
                                          onPressed: () {},
                                          child: const Text("Memasak"),
                                        )
                                      : menuData.statusDetail
                                              .toString()
                                              .contains("menunggu")
                                          ? ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromARGB(
                                                    255, 231, 208, 1),
                                              ),
                                              onPressed: () async {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return MediaQuery(
                                                        data: query.copyWith(
                                                          textScaleFactor: query
                                                              .textScaleFactor
                                                              .clamp(
                                                                  1.0, 1.15)),
                                                      child: AlertDialog(
                                                        content: Image.asset(
                                                          "assets/Logout.png",
                                                          width: 150.0,
                                                          height: 150.0,
                                                          fit: BoxFit.fitHeight,
                                                        ),
                                                        actions: <Widget>[
                                                          Center(
                                                            child: Text(
                                                              "Pesanan Memasak ?",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff3CA2D9),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18.0,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    ElevatedButton(
                                                                  child:
                                                                      Text('Ya'),
                                                                  onPressed:
                                                                      () async {
                                                                    await pesananController.keMemasakOnline(
                                                                        menuData
                                                                            .kantin
                                                                            .toString(),
                                                                        menuData
                                                                            .idMenu,
                                                                        menuData
                                                                            .kodeTr);
                                                                    await pesananController
                                                                        .loadPesananKantin();
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .green,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(width: 8),
                                                              Expanded(
                                                                child:
                                                                    ElevatedButton(
                                                                  child: Text(
                                                                      'Tidak'),
                                                                  onPressed: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
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
                                              child: const Text("Memasak"),
                                            )
                                          : menuData.statusDetail
                                                  .toString()
                                                  .contains("memasak")
                                              ? menuData.noMeja
                                                      .toString()
                                                      .contains("0")
                                                  ? ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      onPressed: () async {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return MediaQuery(
                                                              data: query.copyWith(
                                                                  textScaleFactor: query
                                                                      .textScaleFactor
                                                                      .clamp(
                                                                          1.0,
                                                                          1.15)),
                                                              child:
                                                                  AlertDialog(
                                                                content:
                                                                    Image.asset(
                                                                  "assets/Logout.png",
                                                                  width: 150.0,
                                                                  height: 150.0,
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                ),
                                                                actions: <Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      "Pesanan Selesai ?",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff3CA2D9),
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontSize:
                                                                            18.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            ElevatedButton(
                                                                          child:
                                                                              Text('Ya'),
                                                                          onPressed:
                                                                              () async {
                                                                            await pesananController.keMemasakselesaiOnline(
                                                                                menuData.kantin.toString(),
                                                                                menuData.idMenu,
                                                                                menuData.kodeTr);
                                                                            await pesananController.loadPesananKantin();
                                                                            Navigator.pop(context);
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            backgroundColor:
                                                                                Colors.green,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              8),
                                                                      Expanded(
                                                                        child:
                                                                            ElevatedButton(
                                                                          child:
                                                                              Text('Tidak'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            backgroundColor:
                                                                                Colors.red,
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
                                                      child:
                                                          const Text("Selesai"),
                                                    )
                                                  : ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.blue,
                                                      ),
                                                      onPressed: () async {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return MediaQuery(
                                                              data: query.copyWith(
                                                                  textScaleFactor: query
                                                                      .textScaleFactor
                                                                      .clamp(
                                                                          1.0,
                                                                          1.15)),
                                                              child:
                                                                  AlertDialog(
                                                                content:
                                                                    Image.asset(
                                                                  "assets/Logout.png",
                                                                  width: 150.0,
                                                                  height: 150.0,
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                ),
                                                                actions: <Widget>[
                                                                  Center(
                                                                    child: Text(
                                                                      "Pesanan Selesai ?",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Color(
                                                                            0xff3CA2D9),
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        fontSize:
                                                                            18.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            ElevatedButton(
                                                                          child:
                                                                              Text('Ya'),
                                                                          onPressed:
                                                                              () async {
                                                                            await pesananController.keMemasakselesaiOffline(
                                                                                menuData.kantin.toString(),
                                                                                menuData.idMenu,
                                                                                menuData.kodeTr);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            backgroundColor:
                                                                                Colors.green,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              8),
                                                                      Expanded(
                                                                        child:
                                                                            ElevatedButton(
                                                                          child:
                                                                              Text('Tidak'),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10.0),
                                                                            ),
                                                                            backgroundColor:
                                                                                Colors.red,
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
                                                      child:
                                                          const Text("Selesai"),
                                                    )
                                              : menuData.statusDetail
                                                          .toString()
                                                          .contains(
                                                              "selesai") &&
                                                      menuData.noMeja
                                                          .toString()
                                                          .contains("0")
                                                  ? ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                      onPressed: () async {},
                                                      child: const Text(
                                                          "Menunggu"),
                                                    )
                                                  : ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.green,
                                                      ),
                                                      onPressed: () async {},
                                                      child: const Text(
                                                          "Menunggu"),
                                                    ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              );
            });
      }
    });
  }
}

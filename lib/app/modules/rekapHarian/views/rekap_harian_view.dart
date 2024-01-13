import 'package:dikantin_o_l_d/app/repository/formatRupiah.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/rekap_harian_controller.dart';

class RekapHarianView extends GetView<RekapHarianController> {
  RekapHarianView({Key? key}) : super(key: key);
  final RekapHarianController rekapHarianController =
      Get.find<RekapHarianController>();
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    print('textscalefactor: ${query.textScaleFactor}');
    print('devicePixelRatio: ${query.devicePixelRatio}');
    return MediaQuery(
      data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.0, 1.15)),
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => rekapHarianController.loadRekapHarianAll(),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    info(context),
                    saldo(context),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
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
    final mediaHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Container(
      child: Obx(() {
        if (rekapHarianController.isLoading.value) {
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
        } else if (rekapHarianController.rekapPendapatanharian.data?.isEmpty ??
            true) {
          return Container(
              height: mediaHeight * 0.25,
              child: Center(
                child: Lottie.asset('assets/animation_lokcom8c.json',
                    repeat: false),
              ));
        } else {
          return ListView.builder(
            itemCount: rekapHarianController.rekapPendapatanharian.data!.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              final rekapMenu =
                  rekapHarianController.rekapPendapatanharian.data![index];
              final harga = rekapMenu.totalPendapatan ?? 0;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: const Color.fromARGB(255, 199, 199, 199),
                            blurRadius: 0.4,
                            offset: Offset(1, 2))
                      ]),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child: Row(
                            children: [
                              Text(
                                'Tgl: ${rekapMenu.tanggalTransaksi}',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("|"),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${rekapMenu.jumlahTransaksi} Transaksi',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          )),
                          Text(
                            harga.toRupiah(),
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: Text(
                              ' POLIJE PAY: ${rekapMenu.polijepay} ',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: Text(
                              ' TRANSFER: ${rekapMenu.transferbank} ',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: Text(
                              ' GOPAY: ${rekapMenu.gopay}',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: Text(
                              ' QRIS: ${rekapMenu.qris}',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: Text(
                              ' CASH: ${rekapMenu.cash}',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  5,
                                ),
                              ),
                            ),
                            child: Text(
                              ' GOPAY: 1 ',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[50],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }

  Widget info(BuildContext context) {
    final scale = MediaQuery.of(context).textScaleFactor;

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 5, left: 5, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.info,
                size: 24.0,
                color: Colors.blue,
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                //color: Colors.black,
                // height: MediaQuery.of(context).size.height * 0.16,
                width: MediaQuery.of(context).size.width * 0.77,
                child: Text(
                  textAlign: TextAlign.justify,
                  '''RPH (Rekap Pendapatan Harian) Merekap semua pendapatan anda tiap harinya yang memungkinkan anda jika terdapat rekap harian, yaitu dengan cara pilih "2023-03-01"
                          ''',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: scale <= 1.3 ? 12 : 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget saldo(BuildContext context) {
    final total = rekapHarianController.rekapPendapatanharian.data2 ?? 0;
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Saldo',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
              ),
              Text(
                total.toRupiah(),
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 16, 99, 224),
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(
                () => InkWell(
                  onTap: () {
                    controller.chooseDateRange();
                  },
                  child: Row(
                    children: [
                      Text(
                        DateFormat("dd-MM-yyyy")
                            .format(controller.dateRange.value.start)
                            .toString(),
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal)),
                      ),
                      Text(
                        ' - ',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal)),
                      ),
                      Text(
                        DateFormat("dd-MM-yyyy")
                            .format(controller.dateRange.value.end)
                            .toString(),
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.normal)),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, -1.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: IconButton(
                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                    onPressed: () {
                      controller.chooseDateRange();
                    },
                    iconSize: 24,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:dikantin/model/Penghasilan_bulanan.dart';
import 'package:dikantin/model/Statistik.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dikantin/api/service_Api.dart';

import '../model/Penjualan_mode.dart';

class Beranda extends StatefulWidget {
  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final _service = ServiceApiJumlahPenjualanBulanIni();
  final _api = ServiceApiJumlahPenjualanHariIni();
  // final ServiceApiSuccesDate service = ServiceApiSuccesDate();
  // final ServiceApiProsessDate api = ServiceApiProsessDate();
  final prefs = SharedPreferences.getInstance();
  late Future<List<ModelPenjualan>> listData;
  final listSuccess = ServiceApiSuccesDate();
  final listProses = ServiceApiProsessDate();
  StatistikService penjualanService = StatistikService();
  List<Statistik> data = [];

  String? _kantin;
  @override
  void initState() {
    super.initState();
    // listData = listSuccess.getsuccesdate();
    _getToken();
  }

  void loadData() async {
    try {
      List<Statistik> newData =
          await penjualanService.getStatistik('id_Kantin');
      setState(() {
        data = newData;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // _token = prefs.getString('access_token');

      _kantin = prefs.getString('id_kantin');
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
          children: <Widget>[
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
              'DIKANTIN',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/Group_14.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 40,
                    bottom: 50,
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(115, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                        color: Colors.white,
                        width: 0.5,
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(
                              "Total penghasilan bulan ini",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(child: Container()),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Image.asset("assets/toko_icon.png"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder<int>(
                        future:
                            _service.getJumlahPenjualanBulanIni('id_Kantin'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final jumlahPenjualan = snapshot.data!;
                            final numberFormat = NumberFormat("#,##0", "en_US");
                            final formattedJumlahPenjualan =
                                numberFormat.format(jumlahPenjualan);
                            return Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Rp $formattedJumlahPenjualan',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Color(0xff4a81dc),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Rp 0',
                                style: const TextStyle(
                                  fontSize: 40,
                                  color: Color(0xff4a81dc),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                            // return Text('Error: ${snapshot.error}');
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Rp 0',
                                style: const TextStyle(
                                  fontSize: 40,
                                  color: Color(0xff4a81dc),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "Pendapatan tanggal: " +
                              DateFormat("dd-MM-yyyy").format(DateTime.now()),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          // SizedBox(
                          //   height: 20,
                          // ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: EdgeInsets.only(left: 20),
                              child: FutureBuilder<int>(
                                future:
                                    _api.getJumlahPenjualanHariIni('id_Kantin'),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final jumlahPenjualan = snapshot.data!;
                                    final numberFormat =
                                        NumberFormat("#,##0", "en_US");
                                    final formattedJumlahPenjualan =
                                        numberFormat.format(jumlahPenjualan);
                                    return Text(
                                      'Rp $formattedJumlahPenjualan',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xff398ae8),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                    // );
                                  } else if (snapshot.data == null) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                        'Rp 0',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff398ae8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    // print(snapshot.error);
                                    return Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                        'Rp 0',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff398ae8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                    // return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: Text(
                                        'Rp 0',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xff398ae8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Kantin " + (_kantin?.toString() ?? "0"),
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Expanded(child: Container()),
                          Container(
                            margin: EdgeInsets.only(right: 20),
                            child: Image.asset("assets/Group_2.png"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 12, top: 10),
                child: Text(
                  "Transaksi Hari Ini",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff514d4e),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(width: 10),
                  Container(
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment(-0.5, 0.1),
                              child: Transform.scale(
                                scale: 1.5,
                                child: Image(
                                  image: AssetImage("assets/succes.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0, bottom: 0, left: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Selesai",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff84d895),
                                ),
                              ),
                              FutureBuilder<int>(
                                future: listSuccess
                                    .getsuccesdate(), // Perubahan pada nama metode
                                builder: (context, snapshot) {
                                  final jumlahListSuccess = snapshot.data!;
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Menambahkan pengecekan jika data masih dalam proses pengambilan
                                    return CircularProgressIndicator(); // Misalnya, tampilkan loading indicator
                                  } else if (snapshot.hasData) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 40, bottom: 5),
                                      child: Text(
                                        '$jumlahListSuccess',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff84d895),
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 40, bottom: 5),
                                      child: Text(
                                        '0',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff84d895),
                                        ),
                                      ),
                                    );
                                    // return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 40, bottom: 5),
                                      child: Text(
                                        '0',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff84d895),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 160,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRect(
                            child: Align(
                              alignment: Alignment(-0.5, 0.1),
                              child: Transform.scale(
                                scale: 1.5,
                                child: Image(
                                  image:
                                      AssetImage("assets/tabler_loader-3.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0, bottom: 0, left: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Dilayani",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff87C6E7),
                                ),
                              ),
                              FutureBuilder<int>(
                                future: listProses
                                    .getprosesdate(), // Perubahan pada nama metode
                                builder: (context, snapshot) {
                                  final jumlahListProses = snapshot.data!;
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    // Menambahkan pengecekan jika data masih dalam proses pengambilan
                                    return CircularProgressIndicator(); // Misalnya, tampilkan loading indicator
                                  } else if (snapshot.hasData) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 40, bottom: 5),
                                      child: Text(
                                        '$jumlahListProses',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff87C6E7),
                                        ),
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 40, bottom: 5),
                                      child: Text(
                                        '0',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff84d895),
                                        ),
                                      ),
                                    );
                                    // return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Container(
                                      margin:
                                          EdgeInsets.only(left: 40, bottom: 5),
                                      child: Text(
                                        '0',
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff84d895),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 12, 12, 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.receipt_rounded,
                                    color: Colors.white,
                                    size: 44,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 4),
                                    child: Text(
                                      "p",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Text(
                                    'Untuk Dikirm',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 13,
                    ),
                    Expanded(
                      child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                          child: Container(
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12, 12, 12, 12),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Icon(
                                    Icons.ssid_chart_rounded,
                                    color: Colors.white,
                                    size: 44,
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 8, 0, 4),
                                    child: Text(
                                      "p",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Text(
                                    'Konfirmasi',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 12, top: 10),
              //   child: Text(
              //     "Grafik Penjualan",
              //     style: TextStyle(
              //       fontSize: 15,
              //       color: Color(0xff514d4e),
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   alignment: Alignment.centerLeft,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(right: 10, top: 15),
              //   child: Container(
              //     height: 200,
              //     width: double.infinity,
              //     child: FutureBuilder<List<Statistik>>(
              //       future: penjualanService.getStatistik('id_Kantin'),
              //       builder: (context, snapshot) {
              //         if (snapshot.hasData) {
              //           final data = snapshot.data!;
              //           return LineChart(
              //             LineChartData(
              //               lineBarsData: [
              //                 LineChartBarData(
              //                   spots: data
              //                       .map((item) => FlSpot(
              //                           item.tanggal?.toDouble() ?? 0,
              //                           double.tryParse(item.jumlah ?? '0')
              //                                   ?.toDouble() ??
              //                               0))
              //                       .toList(),
              //                   isCurved: true,
              //                   gradient: LinearGradient(
              //                     begin: Alignment.topRight,
              //                     end: Alignment.bottomLeft,
              //                     colors: [
              //                       Colors.blue,
              //                       Colors.white,
              //                     ],
              //                   ),
              //                   belowBarData: BarAreaData(
              //                     show: true,
              //                     gradient: LinearGradient(
              //                         begin: Alignment.topRight,
              //                         end: Alignment.bottomLeft,
              //                         colors: [Colors.blue, Colors.white]),
              //                   ),
              //                   barWidth: 2,
              //                 ),
              //               ],
              //               titlesData: FlTitlesData(
              //                   // Mengatur label sumbu x dan y menjadi none
              //                   rightTitles: AxisTitles(
              //                     sideTitles: SideTitles(showTitles: false),
              //                     // Tambahkan konfigurasi untuk sumbu y
              //                     // jika diperlukan
              //                   ),
              //                   topTitles: AxisTitles(
              //                     sideTitles: SideTitles(showTitles: false),
              //                     // Tambahkan konfigurasi untuk sumbu x
              //                     // jika diperlukan
              //                   ),

              //                   // Konfigurasi bottom titles
              //                   bottomTitles: AxisTitles(
              //                       sideTitles: SideTitles(showTitles: true))),
              //               backgroundColor: Colors.white,
              //             ),
              //             swapAnimationDuration:
              //                 const Duration(milliseconds: 150),
              //             swapAnimationCurve: Curves.linear,
              //           );
              //         } else if (snapshot.hasError) {
              //           return Text('${snapshot.error}');
              //         } else {
              //           return const CircularProgressIndicator();
              //         }
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

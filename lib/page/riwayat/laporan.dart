import 'dart:io';
import 'package:dikantin/api/service_Api.dart';
import 'package:dikantin/bottom_navigation.dart';
import 'package:dikantin/model/Laporan_model.dart';
import 'package:dikantin/page/riwayat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

class Laporan extends StatefulWidget {
  const Laporan({super.key});

  @override
  State<Laporan> createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  Laporan_Service serviceLaporan = Laporan_Service();
  late Future<List<LaporanModel>> listData;
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // _startDateController.text = DateFormat('yyyy-MM-dd').format(_startDate);
    // _endDateController.text = DateFormat('yyyy-MM-dd').format(_endDate);
    listData = serviceLaporan.getRentangPendapatan(
        _startDateController.text, _endDateController.text);
  }

  Future<void> _CariData() async {
    try {
      final String startDate = DateFormat('yyyy-MM-dd').format(_startDate);
      final String endDate = DateFormat('yyyy-MM-dd').format(_endDate);
      final List<LaporanModel> data =
          await serviceLaporan.getRentangPendapatan(startDate, endDate);

      // final int sumTotal = calculateSumTotal(data);

      setState(() {
        listData = Future.value(data);
      });

      // Lakukan sesuatu dengan sumTotal
      // print('Sum Total: $sumTotal');
    } catch (e) {
      // Tangani kesalahan
    }
  }

  // int calculateSumTotal(List<LaporanModel> data) {
  //   int sumTotal = 0;
  //   for (LaporanModel laporan in data) {
  //     sumTotal += laporan.total ?? 0;
  //   }
  //   return sumTotal;
  // }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
        _startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
        _endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Group_14.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: 400,
                    height: 50,
                    child: Center(
                      child: Text(
                        "LAPORAN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 35),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.4),
                    ),
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50.0),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        splashColor: Colors.white.withOpacity(0.1),
                        highlightColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              height: MediaQuery.of(context).size.height,
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
                padding: const EdgeInsets.only(top: 20, right: 4, left: 4),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          '${_endDate.toString()} ${_startDate.toString()}',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Pilih Rentang Tanggal Untuk Mencetak Laporan Penjualan",
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            padding:
                                EdgeInsets.only(top: 20, left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _startDateController,
                                        decoration: InputDecoration(
                                          labelText: 'Mulai Tanggal',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () =>
                                                _selectStartDate(context),
                                            icon: Icon(Icons.calendar_today),
                                            iconSize: 20, // Ubah ukuran ikon
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize:
                                                  14), // Ubah ukuran label teks
                                        ),
                                        readOnly: true,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        controller: _endDateController,
                                        decoration: InputDecoration(
                                          labelText: 'Sampai Tanggal',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () =>
                                                _selectEndDate(context),
                                            icon: Icon(Icons.calendar_today),
                                            iconSize: 20, // Ubah ukuran ikon
                                          ),
                                          labelStyle: TextStyle(
                                              fontSize:
                                                  14), // Ubah ukuran label teks
                                        ),
                                        readOnly: true,
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      _CariData();
                                    },
                                    icon: const Icon(
                                      Icons.search,
                                      size: 24.0,
                                    ),
                                    label: const Text('Cari Data'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 81,
                                          181, 236), // warna latar belakang
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          constraints: BoxConstraints(
                            minWidth: double.infinity,
                            maxWidth: double.infinity,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xff2E5290),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Text(
                                  'Total :',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Color(0xff87C6E7),
                          child: FutureBuilder<List<LaporanModel>>(
                            future: listData,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<LaporanModel>> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                final data = snapshot.data!;
                                return Column(
                                  children: [
                                    // Text(
                                    //   data.first.sumTotal != null
                                    //       ? NumberFormat.decimalPattern('id_ID')
                                    //           .format(data.first.sumTotal)
                                    //       : '0',
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.bold),
                                    // ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        columnSpacing: 10,
                                        dataRowColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.selected))
                                              return Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(0.08);
                                            return Colors.white;
                                          },
                                        ),
                                        columns: [
                                          DataColumn(
                                              label: Center(child: Text('NO'))),
                                          DataColumn(
                                              label: Center(
                                                  child: Text('Tanggal'))),
                                          DataColumn(
                                              label:
                                                  Center(child: Text('Kasir'))),
                                          DataColumn(
                                              label: Center(
                                                  child: Text('Pesanan'))),
                                          DataColumn(
                                              label: Center(
                                                  child: Text('Jumlah'))),
                                          DataColumn(
                                              label: Center(
                                                  child: Text('Harga Satuan'))),
                                        ],
                                        rows: List<DataRow>.generate(
                                          data.length,
                                          (index) => DataRow(
                                            cells: [
                                              DataCell(Center(
                                                  child: Text(
                                                      (index + 1).toString()))),
                                              DataCell(Center(
                                                  child: Text(data[index]
                                                      .tanggal
                                                      .toString()))),
                                              DataCell(Center(
                                                  child: Text(data[index]
                                                      .kasir
                                                      .toString()))),
                                              DataCell(Center(
                                                  child: Text(data[index]
                                                      .pesanan
                                                      .toString()))),
                                              DataCell(Center(
                                                  child: Text(data[index]
                                                      .jumlah
                                                      .toString()))),
                                              DataCell(
                                                Text(
                                                  NumberFormat.decimalPattern(
                                                          'id_ID')
                                                      .format(data[index]
                                                          .hargaSatuan),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Center(
                                  child: Column(
                                    children: [
                                      Text('Error: ${snapshot.error}'),
                                      Text('Tidak ada data',
                                          style: TextStyle(fontSize: 50)),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

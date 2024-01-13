// To parse this JSON data, do
//
//     final riwayatLaporan = riwayatLaporanFromJson(jsonString);

import 'dart:convert';

RiwayatLaporan riwayatLaporanFromJson(String str) =>
    RiwayatLaporan.fromJson(json.decode(str));

String riwayatLaporanToJson(RiwayatLaporan data) => json.encode(data.toJson());

class RiwayatLaporan {
  Data data;
  int code;
  bool status;

  RiwayatLaporan({
    required this.data,
    required this.code,
    required this.status,
  });

  factory RiwayatLaporan.fromJson(Map<String, dynamic> json) => RiwayatLaporan(
        data: Data.fromJson(json["data"]),
        code: json["code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "code": code,
        "status": status,
      };
}

class Data {
  List<DataRiwayat> dataRiwayat;
  int dataTotal;

  Data({
    required this.dataRiwayat,
    required this.dataTotal,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dataRiwayat: List<DataRiwayat>.from(
            json["dataRiwayat"].map((x) => DataRiwayat.fromJson(x))),
        dataTotal: json["dataTotal"],
      );

  Map<String, dynamic> toJson() => {
        "dataRiwayat": List<dynamic>.from(dataRiwayat.map((x) => x.toJson())),
        "dataTotal": dataTotal,
      };
}

class DataRiwayat {
  String kodeTr;
  DateTime tanggalTransaksi;
  String nama;
  int harga;
  int qty;
  int subtotalHargapokok;
  String statusPengiriman;
  String customerName;
  String noTelepon;
  dynamic username;
  String modelPembayaran;

  DataRiwayat({
    required this.kodeTr,
    required this.tanggalTransaksi,
    required this.nama,
    required this.harga,
    required this.qty,
    required this.subtotalHargapokok,
    required this.statusPengiriman,
    required this.customerName,
    required this.noTelepon,
    required this.username,
    required this.modelPembayaran,
  });

  factory DataRiwayat.fromJson(Map<String, dynamic> json) => DataRiwayat(
        kodeTr: json["kode_tr"],
        tanggalTransaksi: DateTime.parse(json["tanggal_transaksi"]),
        nama: json["nama"],
        harga: json["harga"],
        qty: json["QTY"],
        subtotalHargapokok: json["subtotal_hargapokok"],
        statusPengiriman: json["status_pengiriman"],
        customerName: json["customer_name"],
        noTelepon: json["no_telepon"],
        username: json["username"],
        modelPembayaran: json["model_pembayaran"],
      );

  Map<String, dynamic> toJson() => {
        "kode_tr": kodeTr,
        "tanggal_transaksi":
            "${tanggalTransaksi.year.toString().padLeft(4, '0')}-${tanggalTransaksi.month.toString().padLeft(2, '0')}-${tanggalTransaksi.day.toString().padLeft(2, '0')}",
        "nama": nama,
        "harga": harga,
        "QTY": qty,
        "subtotal_hargapokok": subtotalHargapokok,
        "status_pengiriman": statusPengiriman,
        "customer_name": customerName,
        "no_telepon": noTelepon,
        "username": username,
        "model_pembayaran": modelPembayaran,
      };
}

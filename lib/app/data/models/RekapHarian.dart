class RekapPendapatanharian {
  List<Data>?
      data; // Change the type to List<Data> instead of Map<String, dynamic>?
  int? data2;
  int? code;
  bool? status;

  RekapPendapatanharian({this.data, this.data2, this.code, this.status});

  RekapPendapatanharian.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[]; // Initialize as an empty list
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    data2 = json['data2'];
    code = json['code'];
    status = json['status'];
  }
  Map<String, dynamic> toJson() {
    final jsonData = <String, dynamic>{};
    if (data != null) {
      jsonData['data'] = data?.map((v) => v.toJson()).toList();
    }
    jsonData['data2'] = data2;
    jsonData['code'] = code;
    jsonData['status'] = status;
    return jsonData;
  }
}

class Data {
  String? tanggalTransaksi;
  int? jumlahTransaksi;
  String? cash;
  String? qris;
  String? gopay;
  String? polijepay;
  String? transferbank;
  int? totalPendapatan;

  Data({
    this.tanggalTransaksi,
    this.jumlahTransaksi,
    this.cash,
    this.qris,
    this.gopay,
    this.polijepay,
    this.transferbank,
    this.totalPendapatan,
  });

  Data.fromJson(Map<String, dynamic> json) {
    tanggalTransaksi = json['tanggal_transaksi'];
    jumlahTransaksi = json['jumlah_transaksi'];
    cash = json['cash'];
    qris = json['qris'];
    gopay = json['gopay'];
    polijepay = json['polijepay'];
    transferbank = json['transferbank'];
    totalPendapatan = json['total_pendapatan'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tanggal_transaksi'] = tanggalTransaksi;
    data['jumlah_transaksi'] = jumlahTransaksi;
    data['cash'] = cash;
    data['qris'] = qris;
    data['gopay'] = gopay;
    data['polijepay'] = polijepay;
    data['transferbank'] = transferbank;
    data['total_pendapatan'] = totalPendapatan;
    return data;
  }
}

class RekapHarian {
  Data? data;
  int? code;
  bool? status;

  RekapHarian({this.data, this.code, this.status});

  RekapHarian.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['code'] = code;
    data['status'] = status;
    return data;
  }
}

class Data {
  List<RPH>? rPH;
  int? dataTotal;

  Data({this.rPH, this.dataTotal});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['RPH'] != null) {
      rPH = List<RPH>.from(json['RPH'].map((x) => RPH.fromJson(x)));
    }
    dataTotal = json['dataTotal'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (rPH != null) {
      data['RPH'] = rPH?.map((v) => v.toJson()).toList();
    }
    data['dataTotal'] = dataTotal;
    return data;
  }
}

class RPH {
  String? tanggalTransaksi;
  int? jumlahTransaksi;
  String? cash;
  String? qris;
  String? gopay;
  String? polijepay;
  String? transferbank;
  int? totalPendapatan;

  RPH(
      {this.tanggalTransaksi,
      this.jumlahTransaksi,
      this.cash,
      this.qris,
      this.gopay,
      this.polijepay,
      this.transferbank,
      this.totalPendapatan});

  RPH.fromJson(Map<String, dynamic> json) {
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

class Riwayat {
  List<DataRiwayat>? dataRiwayat;
  int? code;
  bool? status;

  Riwayat({this.dataRiwayat, this.code, this.status});

  Riwayat.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      dataRiwayat = <DataRiwayat>[];
      json['data'].forEach((v) {
        dataRiwayat?.add(DataRiwayat.fromJson(v));
      });
    }
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (this.dataRiwayat != null) {
      data['data'] = this.dataRiwayat?.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['status'] = this.status;

    return data;
  }
}

class DataRiwayat {
  int? idMenu;
  String? nama;
  int? harga;
  String? foto;
  String? statusStok;
  String? kategori;
  int? idKantin;
  dynamic diskon;
  String? penjualanHariIni;
  String? jumlahSubtotal;
  String? createdAt;
  String? updatedAt;

  DataRiwayat(
      {this.idMenu,
      this.nama,
      this.harga,
      this.foto,
      this.statusStok,
      this.kategori,
      this.idKantin,
      this.diskon,
      this.penjualanHariIni,
      this.jumlahSubtotal,
      this.createdAt,
      this.updatedAt});

  DataRiwayat.fromJson(Map<String, dynamic> json) {
    idMenu = json['id_menu'];
    nama = json['nama'];
    harga = json['harga'];
    foto = json['foto'];
    statusStok = json['status_stok'];
    kategori = json['kategori'];
    idKantin = json['id_kantin'];
    diskon = json['diskon'];
    penjualanHariIni = json['penjualan_hari_ini'];
    jumlahSubtotal = json['jumlah_subtotal'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_menu'] = idMenu;
    data['nama'] = nama;
    data['harga'] = harga;
    data['foto'] = foto;
    data['status_stok'] = statusStok;
    data['kategori'] = kategori;
    data['id_kantin'] = idKantin;
    data['diskon'] = diskon;
    data['penjualan_hari_ini'] = penjualanHariIni;
    data['jumlah_subtotal'] = jumlahSubtotal;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Penjualan {
  List<Data>? data;
  int? code;
  bool? status;

  Penjualan({this.data, this.code, this.status});

  Penjualan.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    status = json['status'];
  }

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = {};

  if (this.data != null) {
    data['data'] = this.data?.map((v) => v.toJson()).toList();
  }
  data['code'] = this.code;
  data['status'] = this.status;

  return data;
}

}

class Data {
  int? idMenu;
  String? nama;
  int? harga;
  String? foto;
  String? statusStok;
  String? kategori;
  int? idKantin;
  int? diskon;
  String? penjualanHariIni;

  Data(
      {this.idMenu,
      this.nama,
      this.harga,
      this.foto,
      this.statusStok,
      this.kategori,
      this.idKantin,
      this.diskon,
      this.penjualanHariIni});

  Data.fromJson(Map<String, dynamic> json) {
    idMenu = json['id_menu'];
    nama = json['nama'];
    harga = json['harga'];
    foto = json['foto'];
    statusStok = json['status_stok'];
    kategori = json['kategori'];
    idKantin = json['id_kantin'];
    diskon = json['diskon'];
    penjualanHariIni = json['penjualan_hari_ini'];
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
    return data;
  }
}

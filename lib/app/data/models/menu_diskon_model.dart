class MenuDiskon {
  List<DataDiskon>? data;
  int? code;
  bool? status;

  MenuDiskon({this.data, this.code, this.status});

  MenuDiskon.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataDiskon>[];
      json['data'].forEach((v) {
        data?.add(DataDiskon.fromJson(v));
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

class DataDiskon {
  int? idMenu;
  String? nama;
  int? harga;
  String? foto;
  String? statusStok;
  String? kategori;
  int? idKantin;
  int? diskon;

  DataDiskon(
      {this.idMenu,
      this.nama,
      this.harga,
      this.foto,
      this.statusStok,
      this.kategori,
      this.idKantin,
      this.diskon});

  DataDiskon.fromJson(Map<String, dynamic> json) {
    idMenu = json['id_menu'];
    nama = json['nama'];
    harga = json['harga'];
    foto = json['foto'];
    statusStok = json['status_stok'];
    kategori = json['kategori'];
    idKantin = json['id_kantin'];
    diskon = json['diskon'];
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
    return data;
  }
}

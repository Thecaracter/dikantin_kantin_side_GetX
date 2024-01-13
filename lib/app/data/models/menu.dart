class Menu {
  List<DataMenu>? data;
  int? code;
  bool? status;

  Menu({this.data, this.code, this.status});

  Menu.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataMenu>[];
      json['data'].forEach((v) {
        data?.add(DataMenu.fromJson(v));
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

class DataMenu {
  int? idMenu;
  String? nama;
  int? hargaPokok;
  int? harga;
  String? foto;
  String? statusStok;
  String? kategori;
  int? idKantin;
  dynamic diskon;
  String? createdAt;
  String? updatedAt;

  DataMenu(
      {this.idMenu,
      this.nama,
      this.hargaPokok,
      this.harga,
      this.foto,
      this.statusStok,
      this.kategori,
      this.idKantin,
      this.diskon,
      this.createdAt,
      this.updatedAt});

  DataMenu.fromJson(Map<String, dynamic> json) {
    idMenu = json['id_menu'];
    nama = json['nama'];
    hargaPokok =json['harga_pokok'];
    harga = json['harga'];
    foto = json['foto'];
    statusStok = json['status_stok'];
    kategori = json['kategori'];
    idKantin = json['id_kantin'];
    diskon = json['diskon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_menu'] = idMenu;
    data['nama'] = nama;
    data['harga_pokok'] = hargaPokok;
    data['harga'] = harga;
    data['foto'] = foto;
    data['status_stok'] = statusStok;
    data['kategori'] = kategori;
    data['id_kantin'] = idKantin;
    data['diskon'] = diskon;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

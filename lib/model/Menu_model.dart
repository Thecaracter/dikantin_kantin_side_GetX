class MenuApi {
  int? id;
  String? namaMenu;
  int? harga;
  String? foto;
  String? statusStok;
  int? idKantin;
  int? diskon;
  String? createdAt;
  String? updatedAt;
  Kantins? kantins;

  MenuApi(
      {this.id,
      this.namaMenu,
      this.harga,
      this.foto,
      this.statusStok,
      this.idKantin,
      this.diskon,
      this.createdAt,
      this.updatedAt,
      this.kantins});

  MenuApi.fromJson(Map<String, dynamic> json) {
    id = json['id_menu'];
    namaMenu = json['nama'];
    harga = json['harga'];
    foto = json['foto'];
    statusStok = json['status_stok'];
    idKantin = json['id_kantin'];
    diskon = json['diskon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kantins =
        json['kantins'] != null ? new Kantins.fromJson(json['kantins']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_menu'] = this.namaMenu;
    data['harga'] = this.harga;
    data['foto'] = this.foto;
    data['status_stok'] = this.statusStok;
    data['id_kantin'] = this.idKantin;
    data['diskon'] = this.diskon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.kantins != null) {
      data['kantins'] = this.kantins!.toJson();
    }
    return data;
  }
}

class Kantins {
  int? id;
  String? namaKantin;
  String? statusAktif;
  Null? createdAt;
  Null? updatedAt;
  int? idUser;

  Kantins(
      {this.id,
      this.namaKantin,
      this.statusAktif,
      this.createdAt,
      this.updatedAt,
      this.idUser});

  Kantins.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKantin = json['nama_kantin'];
    statusAktif = json['status_aktif'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idUser = json['id_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_kantin'] = this.namaKantin;
    data['status_aktif'] = this.statusAktif;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id_user'] = this.idUser;
    return data;
  }
}

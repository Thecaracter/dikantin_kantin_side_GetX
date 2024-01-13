class userGet {
  int? id;
  String? name;
  String? username;
  String? email;
  Null? emailVerifiedAt;
  int? idKantin;
  String? foto;
  String? createdAt;
  String? updatedAt;
  Kantins? kantins;

  userGet(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.emailVerifiedAt,
      this.idKantin,
      this.foto,
      this.createdAt,
      this.updatedAt,
      this.kantins});

  userGet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    idKantin = json['id_kantin'];
    foto = json['foto'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kantins =
        json['kantins'] != null ? new Kantins.fromJson(json['kantins']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['id_kantin'] = this.idKantin;
    data['foto'] = this.foto;
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

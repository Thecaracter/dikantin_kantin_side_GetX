class ProfileKurir {
  Data? data;
  int? code;
  bool? status;

  ProfileKurir({this.data, this.code, this.status});

  ProfileKurir.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data?.fromJson(json['data']) : null;
    code = json['code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? idKurir;
  String? email;
  String? nama;
  int? status;
  String? token;
  String? tokenFcm;
  String? telepon;
  dynamic foto;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.idKurir,
      this.email,
      this.nama,
      this.status,
      this.token,
      this.tokenFcm,
      this.telepon,
      this.foto,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    idKurir = json['id_kurir'];
    email = json['email'];
    nama = json['nama'];
    status = json['status'];
    token = json['token'];
    tokenFcm = json['token_fcm'];
    telepon = json['telepon'];
    foto = json['foto'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id_kurir'] = idKurir;
    data['email'] = email;
    data['nama'] = nama;
    data['status'] = status;
    data['token'] = token;
    data['token_fcm'] = tokenFcm;
    data['telepon'] = telepon;
    data['foto'] = foto;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

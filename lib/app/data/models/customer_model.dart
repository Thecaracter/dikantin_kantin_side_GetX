class Customer {
  Data? data;
  int? code;
  bool? status;

  Customer({this.data, this.code, this.status});

  Customer.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    code = json['code'];
    status = json['status'] ??
        false; // Tambahkan pengecekan null dan berikan nilai default
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
  String? idCustomer;
  String? nama;
  String? noTelepon;
  int? emailVerified;
  Null? kodeVerified;
  String? token;
  Null? tokenFcm;
  String? alamat;
  String? email;
  Null? foto;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.idCustomer,
      this.nama,
      this.noTelepon,
      this.emailVerified,
      this.kodeVerified,
      this.token,
      this.tokenFcm,
      this.alamat,
      this.email,
      this.foto,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    idCustomer = json['id_customer'];
    nama = json['nama'];
    noTelepon = json['no_telepon'];
    emailVerified = json['email_verified'];
    kodeVerified = json['kode_verified'];
    token = json['token'];
    tokenFcm = json['token_fcm'];
    alamat = json['alamat'];
    email = json['email'];
    foto = json['foto'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_customer'] = this.idCustomer;
    data['nama'] = this.nama;
    data['no_telepon'] = this.noTelepon;
    data['email_verified'] = this.emailVerified;
    data['kode_verified'] = this.kodeVerified;
    data['token'] = this.token;
    data['token_fcm'] = this.tokenFcm;
    data['alamat'] = this.alamat;
    data['email'] = this.email;
    data['foto'] = this.foto;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

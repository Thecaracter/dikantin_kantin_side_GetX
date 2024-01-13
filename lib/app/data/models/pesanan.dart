class Test {
  List<Data>? data;
  int? code;
  bool? status;

  Test({this.data, this.code, this.status});

  Test.fromJson(Map<String, dynamic> json) {
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
    final jsonData = <String, dynamic>{};
    if (data != null) {
      jsonData['data'] = data?.map((v) => v.toJson()).toList();
    }
    jsonData['code'] = code;
    jsonData['status'] = status;
    return jsonData;
  }
}

class Data {
  String? foto;
  int? idMenu;
  String? idDetail;
  String? tanggal;
  String? kodeTr;
  String? catatan;
  String? pembeli;
  String? noTeleponPembeli;
  String? modelPembayaran;
  int? noMeja;
  int? kantin;
  String? pesanan;
  int? hargaSatuan;
  int? jumlah;
  dynamic diskon;
  String? status;
  String? statusDetail;

  Data(
      {this.foto,
      this.idMenu,
      this.idDetail,
      this.tanggal,
      this.kodeTr,
      this.catatan,
      this.pembeli,
      this.noTeleponPembeli,
      this.modelPembayaran,
      this.noMeja,
      this.kantin,
      this.pesanan,
      this.hargaSatuan,
      this.jumlah,
      this.diskon,
      this.status,
      this.statusDetail});

  Data.fromJson(Map<String, dynamic> json) {
    foto = json['foto'];
    idMenu = json['id_menu'];
    idDetail = json['id_detail'];
    tanggal = json['tanggal'];
    kodeTr = json['kode_tr'];
    catatan = json['catatan'];
    pembeli = json['pembeli'];
    noTeleponPembeli = json['no_telepon_pembeli'];
    modelPembayaran = json['model_pembayaran'];
    noMeja = json['no_meja'];
    kantin = json['kantin'];
    pesanan = json['pesanan'];
    hargaSatuan = json['harga_satuan'];
    jumlah = json['jumlah'];
    diskon = json['diskon'];
    status = json['status'];
    statusDetail = json['status_detail'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['foto'] = foto;
    data['id_menu'] = idMenu;
    data['id_detail'] = idDetail;
    data['tanggal'] = tanggal;
    data['kode_tr'] = kodeTr;
    data['catatan'] = catatan;
    data['pembeli'] = pembeli;
    data['no_telepon_pembeli'] = noTeleponPembeli;
    data['model_pembayaran'] = modelPembayaran;
    data['no_meja'] = noMeja;
    data['kantin'] = kantin;
    data['pesanan'] = pesanan;
    data['harga_satuan'] = hargaSatuan;
    data['jumlah'] = jumlah;
    data['diskon'] = diskon;
    data['status'] = status;
    data['status_detail'] = statusDetail;
    return data;
  }
}

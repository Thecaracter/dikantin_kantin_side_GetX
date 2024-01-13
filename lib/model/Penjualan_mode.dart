// ignore_for_file: non_constant_identifier_names

class ModelPenjualan {
  String? foto;
  int? idMenu;
  String? idDetail;
  String? tanggal;
  String? nomerPenjualan;
  String? pembeli;
  String? noTeleponPembeli;
  String? kasir;
  String? modelPembayaran;
  int? noMeja;
  int? kantin;
  String? pesanan;
  int? hargaSatuan;
  int? jumlah;
  int? diskon;
  String? status;
  String? status_detail;

  ModelPenjualan(
      {this.foto,
      this.idMenu,
      this.idDetail,
      this.tanggal,
      this.nomerPenjualan,
      this.pembeli,
      this.noTeleponPembeli,
      this.kasir,
      this.modelPembayaran,
      this.noMeja,
      this.kantin,
      this.pesanan,
      this.hargaSatuan,
      this.jumlah,
      this.diskon,
      this.status,
      this.status_detail});

  ModelPenjualan.fromJson(Map<String, dynamic> json) {
    foto = json['foto'];
    idMenu = json['id_menu'];
    idDetail = json['id_detail'];
    tanggal = json['tanggal'];
    nomerPenjualan = json['nomer_penjualan'];
    pembeli = json['pembeli'];
    noTeleponPembeli = json['no_telepon_pembeli'];
    kasir = json['kasir'];
    modelPembayaran = json['model_pembayaran'];
    noMeja = json['no_meja'];
    kantin = json['kantin'];
    pesanan = json['pesanan'];
    hargaSatuan = json['harga_satuan'];
    jumlah = json['jumlah'];
    diskon = json['diskon'];
    status = json['status'];
    status_detail = json['status_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foto'] = this.foto;
    data['id_menu'] = this.idMenu;
    data['id_detail'] = this.idDetail;
    data['tanggal'] = this.tanggal;
    data['nomer_penjualan'] = this.nomerPenjualan;
    data['pembeli'] = this.pembeli;
    data['no_telepon_pembeli'] = this.noTeleponPembeli;
    data['kasir'] = this.kasir;
    data['model_pembayaran'] = this.modelPembayaran;
    data['no_meja'] = this.noMeja;
    data['kantin'] = this.kantin;
    data['pesanan'] = this.pesanan;
    data['harga_satuan'] = this.hargaSatuan;
    data['jumlah'] = this.jumlah;
    data['diskon'] = this.diskon;
    data['status'] = this.status;
    data['status_detail'] = this.status_detail;
    return data;
  }
}

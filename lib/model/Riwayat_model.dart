class ModelRiwayat {
  String? foto;
  int? idDetail;
  String? tanggal;
  int? nomerPenjualan;
  String? pembeli;
  String? noTeleponPembeli;
  String? kasir;
  String? modelPembayaran;
  int? noMeja;
  String? kantin;
  String? pesanan;
  int? hargaSatuan;
  int? jumlah;
  int? diskon;
  String? status;

  ModelRiwayat(
      {this.foto,
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
      this.status});

  ModelRiwayat.fromJson(Map<String, dynamic> json) {
    foto = json['foto'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foto'] = this.foto;
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
    return data;
  }
}

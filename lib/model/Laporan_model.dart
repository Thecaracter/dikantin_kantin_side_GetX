class LaporanModel {
  final String? tanggal;
  final int? nomerPenjualan;
  final String? pembeli;
  final String? kasir;
  final String? kantin;
  final String? pesanan;
  final int? hargaSatuan;
  final int? jumlah;
  final dynamic diskon;
  final String? status;
  // final int? total;

  LaporanModel({
    this.tanggal,
    this.nomerPenjualan,
    this.pembeli,
    this.kasir,
    this.kantin,
    this.pesanan,
    this.hargaSatuan,
    this.jumlah,
    this.diskon,
    this.status,
    // this.total,
  });

  factory LaporanModel.fromJson(Map<String, dynamic> json) {
    return LaporanModel(
      tanggal: json['tanggal'] as String?,
      nomerPenjualan: json['nomer_penjualan'] as int?,
      pembeli: json['pembeli'] as String?,
      kasir: json['kasir'] as String?,
      kantin: json['kantin'] as String?,
      pesanan: json['pesanan'] as String?,
      hargaSatuan: json['harga_satuan'] as int?,
      jumlah: json['jumlah'] as int?,
      diskon: json['diskon'],
      status: json['status'] as String?,
      // total: json['total'] as int?,
    );
  }
}

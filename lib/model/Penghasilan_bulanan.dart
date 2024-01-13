class PenghasilanBulanan {
  int? jumlahPenjualan;

  PenghasilanBulanan({this.jumlahPenjualan});

  PenghasilanBulanan.fromJson(Map<String, dynamic> json) {
    jumlahPenjualan = json['jumlah_penjualan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jumlah_penjualan'] = this.jumlahPenjualan;
    return data;
  }
}
